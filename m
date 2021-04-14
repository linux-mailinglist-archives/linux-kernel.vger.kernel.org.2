Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2761F35EA16
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 02:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348868AbhDNApd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 20:45:33 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61113 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346439AbhDNApd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 20:45:33 -0400
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 13E0jBBQ067700;
        Wed, 14 Apr 2021 09:45:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp);
 Wed, 14 Apr 2021 09:45:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 13E0jBpw067692
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 14 Apr 2021 09:45:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: How to handle concurrent access to /dev/ttyprintk ?
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Samo Pogacnik <samo_pogacnik@t-2.net>,
        Petr Mladek <pmladek@suse.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <YGx59PEq2Y015YdK@alley>
 <3c15d32f-c568-7f6f-fa7e-af4deb9b49f9@i-love.sakura.ne.jp>
 <d78ae8da-16e9-38d9-e274-048c54e24360@i-love.sakura.ne.jp>
 <YG24F9Kx+tjxhh8G@kroah.com>
 <051b550c-1cdd-6503-d2b7-0877bf0578fc@i-love.sakura.ne.jp>
 <cd213843-45fe-2eac-4943-0906ab8d272b@i-love.sakura.ne.jp>
 <YHQkeZVs3pmyie9e@kroah.com>
 <32e75be6-6e9f-b33f-d585-13db220519da@i-love.sakura.ne.jp>
 <YHQ3Zy9gRdZsu77w@kroah.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <ffcc8099-614c-f4b1-10c1-f1d4c7f72e65@i-love.sakura.ne.jp>
Date:   Wed, 14 Apr 2021 09:45:07 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YHQ3Zy9gRdZsu77w@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/04/12 21:04, Greg Kroah-Hartman wrote:
>> Since syzkaller is a fuzzer, syzkaller happily opens /dev/ttyprintk from
>> multiple threads. Should we update syzkaller to use CONFIG_TTY_PRINTK=n ?
> 
> Why?  Can you not hit the same tty code paths from any other tty driver
> being open multiple times?  Why is ttyprintk somehow "special" here?

I found a simplified reproducer. If we call ioctl(TIOCVHANGUP) on /dev/ttyprintk ,
"struct ttyprintk_port tpk_port".port.count cannot be decremented by
tty_port_close() from tpk_close() due to tty_hung_up_p() == true when
close() is called. As a result, tty->count and port count gets out of sync.

Then, when /dev/ttyprintk is opened again and then closed without calling
ioctl(TIOCVHANGUP), this message is printed due to tty_hung_up_p() == false.

---------- Debug print patch start ----------
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 391bada4cedb..42d54368adac 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -113,7 +113,7 @@
 #ifdef TTY_DEBUG_HANGUP
 # define tty_debug_hangup(tty, f, args...)	tty_debug(tty, f, ##args)
 #else
-# define tty_debug_hangup(tty, f, args...)	do { } while (0)
+# define tty_debug_hangup(tty, f, args...)	tty_info(tty, f, ##args)
 #endif
 
 #define TTY_PARANOIA_CHECK 1
@@ -628,6 +628,7 @@ static void __tty_hangup(struct tty_struct *tty, int exit_session)
 		closecount++;
 		__tty_fasync(-1, filp, 0);	/* can't block */
 		filp->f_op = &hung_up_tty_fops;
+		tty_warn(tty, "Set hung_up_tty_fops on %px\n", filp);
 	}
 	spin_unlock(&tty->files_lock);
 
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 346d20f4a486..032fc58203ea 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -561,8 +561,10 @@ int tty_port_close_start(struct tty_port *port,
 {
 	unsigned long flags;
 
-	if (tty_hung_up_p(filp))
+	if (tty_hung_up_p(filp)) {
+		tty_warn(tty, "Skipped by hung_up_tty_fops on %px\n", filp);
 		return 0;
+	}
 
 	spin_lock_irqsave(&port->lock, flags);
 	if (tty->count == 1 && port->count != 1) {
---------- Debug print patch end ----------

---------- Reproducer start ----------
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
	int i;
	int fd[10];

	for (i = 0; i < 10; i++)
		fd[i] = open("/dev/ttyprintk", O_WRONLY);
	ioctl(fd[0], TIOCVHANGUP);
	for (i = 0; i < 10; i++)
		close(fd[i]);
	close(open("/dev/ttyprintk", O_WRONLY));
	return 0;
}
---------- Reproducer end ----------

---------- Console output start ----------
[   31.885820] ttyprintk ttyprintk: opening (count=1)
[   31.885859] ttyprintk ttyprintk: opening (count=2)
[   31.885876] ttyprintk ttyprintk: opening (count=3)
[   31.885892] ttyprintk ttyprintk: opening (count=4)
[   31.885907] ttyprintk ttyprintk: opening (count=5)
[   31.885923] ttyprintk ttyprintk: opening (count=6)
[   31.885939] ttyprintk ttyprintk: opening (count=7)
[   31.885956] ttyprintk ttyprintk: opening (count=8)
[   31.885971] ttyprintk ttyprintk: opening (count=9)
[   31.885988] ttyprintk ttyprintk: opening (count=10)
[   31.885999] ttyprintk ttyprintk: vhangup
[   31.886005] ttyprintk ttyprintk: Set hung_up_tty_fops on ffff97c38eed1000
[   31.886009] ttyprintk ttyprintk: Set hung_up_tty_fops on ffff97c38eed2000
[   31.886012] ttyprintk ttyprintk: Set hung_up_tty_fops on ffff97c38eed0c00
[   31.886016] ttyprintk ttyprintk: Set hung_up_tty_fops on ffff97c38eed0e00
[   31.886019] ttyprintk ttyprintk: Set hung_up_tty_fops on ffff97c38eed2c00
[   31.886023] ttyprintk ttyprintk: Set hung_up_tty_fops on ffff97c38eed3a00
[   31.886026] ttyprintk ttyprintk: Set hung_up_tty_fops on ffff97c38eed3400
[   31.886029] ttyprintk ttyprintk: Set hung_up_tty_fops on ffff97c38eed3c00
[   31.886033] ttyprintk ttyprintk: Set hung_up_tty_fops on ffff97c38eed0200
[   31.886036] ttyprintk ttyprintk: Set hung_up_tty_fops on ffff97c38eed3e00
[   31.886055] ttyprintk ttyprintk: releasing (count=10)
[   31.886106] ttyprintk ttyprintk: Skipped by hung_up_tty_fops on ffff97c38eed3e00
[   31.886117] ttyprintk ttyprintk: releasing (count=9)
[   31.886121] ttyprintk ttyprintk: Skipped by hung_up_tty_fops on ffff97c38eed0200
[   31.886128] ttyprintk ttyprintk: releasing (count=8)
[   31.886131] ttyprintk ttyprintk: Skipped by hung_up_tty_fops on ffff97c38eed3c00
[   31.886138] ttyprintk ttyprintk: releasing (count=7)
[   31.886141] ttyprintk ttyprintk: Skipped by hung_up_tty_fops on ffff97c38eed3400
[   31.886148] ttyprintk ttyprintk: releasing (count=6)
[   31.886151] ttyprintk ttyprintk: Skipped by hung_up_tty_fops on ffff97c38eed3a00
[   31.886158] ttyprintk ttyprintk: releasing (count=5)
[   31.886161] ttyprintk ttyprintk: Skipped by hung_up_tty_fops on ffff97c38eed2c00
[   31.886168] ttyprintk ttyprintk: releasing (count=4)
[   31.886171] ttyprintk ttyprintk: Skipped by hung_up_tty_fops on ffff97c38eed0e00
[   31.886178] ttyprintk ttyprintk: releasing (count=3)
[   31.886181] ttyprintk ttyprintk: Skipped by hung_up_tty_fops on ffff97c38eed0c00
[   31.886188] ttyprintk ttyprintk: releasing (count=2)
[   31.886191] ttyprintk ttyprintk: Skipped by hung_up_tty_fops on ffff97c38eed2000
[   31.886198] ttyprintk ttyprintk: releasing (count=1)
[   31.886201] ttyprintk ttyprintk: Skipped by hung_up_tty_fops on ffff97c38eed1000
[   31.886205] ttyprintk ttyprintk: final close
[   31.886211] ttyprintk ttyprintk: freeing structure
[   31.886277] ttyprintk ttyprintk: opening (count=1)
[   31.886531] ttyprintk ttyprintk: releasing (count=1)
[   31.886535] ttyprintk ttyprintk: tty_port_close_start: tty->count = 1 port count = 11
[   31.886543] ttyprintk ttyprintk: final close
[   31.886552] ttyprintk ttyprintk: freeing structure
---------- Console output end ----------

If I replace /dev/ttyprintk with /dev/ttyS0 in the reproducer shown above,
this message is not printed.

---------- Console output start ----------
[   10.794802] ttyS ttyS0: opening (count=1)
[   10.795851] ttyS ttyS0: opening (count=2)
[   10.795872] ttyS ttyS0: opening (count=3)
[   10.795890] ttyS ttyS0: opening (count=4)
[   10.795908] ttyS ttyS0: opening (count=5)
[   10.795925] ttyS ttyS0: opening (count=6)
[   10.795943] ttyS ttyS0: opening (count=7)
[   10.795960] ttyS ttyS0: opening (count=8)
[   10.795978] ttyS ttyS0: opening (count=9)
[   10.795995] ttyS ttyS0: opening (count=10)
[   10.796007] ttyS ttyS0: vhangup
[   10.796014] ttyS ttyS0: Set hung_up_tty_fops on ffff9cb044dc5600
[   10.796020] ttyS ttyS0: Set hung_up_tty_fops on ffff9cb044dc6400
[   10.796025] ttyS ttyS0: Set hung_up_tty_fops on ffff9cb044dc4a00
[   10.796030] ttyS ttyS0: Set hung_up_tty_fops on ffff9cb044dc6800
[   10.796035] ttyS ttyS0: Set hung_up_tty_fops on ffff9cb044dc6200
[   10.796039] ttyS ttyS0: Set hung_up_tty_fops on ffff9cb044dc5a00
[   10.796044] ttyS ttyS0: Set hung_up_tty_fops on ffff9cb044dc6600
[   10.796048] ttyS ttyS0: Set hung_up_tty_fops on ffff9cb044dc7600
[   10.796053] ttyS ttyS0: Set hung_up_tty_fops on ffff9cb044dc5e00
[   10.796058] ttyS ttyS0: Set hung_up_tty_fops on ffff9cb044dc6000
[   10.796401] ttyS ttyS0: releasing (count=10)
[   10.796408] ttyS ttyS0: Skipped by hung_up_tty_fops on ffff9cb044dc6000
[   10.796434] ttyS ttyS0: releasing (count=9)
[   10.796439] ttyS ttyS0: Skipped by hung_up_tty_fops on ffff9cb044dc5e00
[   10.796447] ttyS ttyS0: releasing (count=8)
[   10.796451] ttyS ttyS0: Skipped by hung_up_tty_fops on ffff9cb044dc7600
[   10.796459] ttyS ttyS0: releasing (count=7)
[   10.796463] ttyS ttyS0: Skipped by hung_up_tty_fops on ffff9cb044dc6600
[   10.796472] ttyS ttyS0: releasing (count=6)
[   10.796476] ttyS ttyS0: Skipped by hung_up_tty_fops on ffff9cb044dc5a00
[   10.796484] ttyS ttyS0: releasing (count=5)
[   10.796488] ttyS ttyS0: Skipped by hung_up_tty_fops on ffff9cb044dc6200
[   10.796496] ttyS ttyS0: releasing (count=4)
[   10.796500] ttyS ttyS0: Skipped by hung_up_tty_fops on ffff9cb044dc6800
[   10.796508] ttyS ttyS0: releasing (count=3)
[   10.796512] ttyS ttyS0: Skipped by hung_up_tty_fops on ffff9cb044dc4a00
[   10.796521] ttyS ttyS0: releasing (count=2)
[   10.796525] ttyS ttyS0: Skipped by hung_up_tty_fops on ffff9cb044dc6400
[   10.796533] ttyS ttyS0: releasing (count=1)
[   10.796537] ttyS ttyS0: Skipped by hung_up_tty_fops on ffff9cb044dc5600
[   10.796542] ttyS ttyS0: final close
[   10.796548] ttyS ttyS0: freeing structure
[   10.796634] ttyS ttyS0: opening (count=1)
[   10.797192] ttyS ttyS0: releasing (count=1)
[   10.797413] ttyS ttyS0: final close
[   10.797427] ttyS ttyS0: freeing structure
---------- Console output end ----------

