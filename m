Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94BE454535
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 11:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbhKQKyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 05:54:18 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:63844 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbhKQKyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 05:54:16 -0500
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1AHApGKT068206;
        Wed, 17 Nov 2021 19:51:16 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Wed, 17 Nov 2021 19:51:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1AHApGO6068201
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 17 Nov 2021 19:51:16 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <df266c83-88df-4d1a-5c7e-ea0214f3de3b@i-love.sakura.ne.jp>
Date:   Wed, 17 Nov 2021 19:51:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] vt: Fix sleeping functions called from atomic context
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Peter Hurley <peter@hurleysoftware.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        nick black <dankamongmen@gmail.com>,
        linux-kernel@vger.kernel.org,
        syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com,
        Marco Elver <elver@google.com>
References: <20211116144937.19035-1-fmdefrancesco@gmail.com>
 <2524108.PJBYKFOWIp@localhost.localdomain> <YZPjbI/uCNtugFJZ@kroah.com>
 <1851530.LmWsTuDv9j@localhost.localdomain> <YZTDY/h8HcEkq7mO@kroah.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <YZTDY/h8HcEkq7mO@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/17 17:54, Greg Kroah-Hartman wrote:
> Great, you have a reproducer, so you should be able to duplicate this
> locally to figure out what is really happening here.

Until commit ac751efa6a0d70f2 ("console: rename acquire/release_console_sem() to
console_lock/unlock()"), do_con_write() was surely designed to be able to sleep.

$ git blame ac751efa6a0d7~1 drivers/tty/vt/vt.c
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2122) /* acquires console_sem */
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2123) static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int count)
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2124) {
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2125) #ifdef VT_BUF_VRAM_ONLY
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2126) #define FLUSH do { } while(0);
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2127) #else
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2128) #define FLUSH if (draw_x >= 0) { \
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2129)  vc->vc_sw->con_putcs(vc, (u16 *)draw_from, (u16 *)draw_to - (u16 *)draw_from, vc->vc_y, draw_x); \
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2130)  draw_x = -1; \
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2131)  }
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2132) #endif
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2133)
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2134)  int c, tc, ok, n = 0, draw_x = -1;
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2135)  unsigned int currcons;
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2136)  unsigned long draw_from = 0, draw_to = 0;
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2137)  struct vc_data *vc;
2f1a2ccb9c0de drivers/char/vt.c   (Egmont Koblinger    2007-05-08 00:30:37 -0700 2138)  unsigned char vc_attr;
0341a4d0fdd2a drivers/char/vt.c   (Karl Dahlke         2008-04-28 02:14:25 -0700 2139)  struct vt_notifier_param param;
2f1a2ccb9c0de drivers/char/vt.c   (Egmont Koblinger    2007-05-08 00:30:37 -0700 2140)  uint8_t rescan;
2f1a2ccb9c0de drivers/char/vt.c   (Egmont Koblinger    2007-05-08 00:30:37 -0700 2141)  uint8_t inverse;
2f1a2ccb9c0de drivers/char/vt.c   (Egmont Koblinger    2007-05-08 00:30:37 -0700 2142)  uint8_t width;
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2143)  u16 himask, charmask;
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2144)
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2145)  if (in_interrupt())
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2146)          return count;
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2147)
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2148)  might_sleep();
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2149)
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2150)  acquire_console_sem();
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2151)  vc = tty->driver_data;
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2152)  if (vc == NULL) {
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2153)          printk(KERN_ERR "vt: argh, driver_data is NULL !\n");
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2154)          release_console_sem();
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2155)          return 0;
^1da177e4c3f4 drivers/char/vt.c   (Linus Torvalds      2005-04-16 15:20:36 -0700 2156)  }

Until that commit, n_hdlc_send_frames() was prepared for being interrupted by signal
while sleeping.

$ git blame ac751efa6a0d7~1 drivers/tty/n_hdlc.c
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  379) /**
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  380)  * n_hdlc_send_frames - send frames on pending send buffer list
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  381)  * @n_hdlc - pointer to ldisc instance data
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  382)  * @tty - pointer to tty instance data
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  383)  *
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  384)  * Send frames on pending send buffer list until the driver does not accept a
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  385)  * frame (busy) this function is called after adding a frame to the send buffer
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  386)  * list and by the tty wakeup callback.
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  387)  */
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  388) static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  389) {
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  390)    register int actual;
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  391)    unsigned long flags;
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  392)    struct n_hdlc_buf *tbuf;
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  393)
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  394)    if (debuglevel >= DEBUG_LEVEL_INFO)
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  395)            printk("%s(%d)n_hdlc_send_frames() called\n",__FILE__,__LINE__);
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  396)  check_again:
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  397)
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  398)    spin_lock_irqsave(&n_hdlc->tx_buf_list.spinlock, flags);
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  399)    if (n_hdlc->tbusy) {
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  400)            n_hdlc->woke_up = 1;
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  401)            spin_unlock_irqrestore(&n_hdlc->tx_buf_list.spinlock, flags);
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  402)            return;
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  403)    }
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  404)    n_hdlc->tbusy = 1;
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  405)    n_hdlc->woke_up = 0;
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  406)    spin_unlock_irqrestore(&n_hdlc->tx_buf_list.spinlock, flags);
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  407)
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  408)    /* get current transmit buffer or get new transmit */
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  409)    /* buffer from list of pending transmit buffers */
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  410)
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  411)    tbuf = n_hdlc->tbuf;
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  412)    if (!tbuf)
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  413)            tbuf = n_hdlc_buf_get(&n_hdlc->tx_buf_list);
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  414)
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  415)    while (tbuf) {
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  416)            if (debuglevel >= DEBUG_LEVEL_INFO)
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  417)                    printk("%s(%d)sending frame %p, count=%d\n",
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  418)                            __FILE__,__LINE__,tbuf,tbuf->count);
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  419)
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  420)            /* Send the next block of data to device */
^1da177e4c3f4 drivers/char/n_hdlc.c (Linus Torvalds  2005-04-16 15:20:36 -0700  421)            tty->flags |= (1 << TTY_DO_WRITE_WAKEUP);
f34d7a5b7010b drivers/char/n_hdlc.c (Alan Cox        2008-04-30 00:54:13 -0700  422)            actual = tty->ops->write(tty, tbuf->buf, tbuf->count);
b0fed3140f57c drivers/char/n_hdlc.c (Jiri Slaby      2007-07-15 23:40:12 -0700  423)
b0fed3140f57c drivers/char/n_hdlc.c (Jiri Slaby      2007-07-15 23:40:12 -0700  424)            /* rollback was possible and has been done */
b0fed3140f57c drivers/char/n_hdlc.c (Jiri Slaby      2007-07-15 23:40:12 -0700  425)            if (actual == -ERESTARTSYS) {
b0fed3140f57c drivers/char/n_hdlc.c (Jiri Slaby      2007-07-15 23:40:12 -0700  426)                    n_hdlc->tbuf = tbuf;
b0fed3140f57c drivers/char/n_hdlc.c (Jiri Slaby      2007-07-15 23:40:12 -0700  427)                    break;
b0fed3140f57c drivers/char/n_hdlc.c (Jiri Slaby      2007-07-15 23:40:12 -0700  428)            }

But as of commit c545b66c6922b002 ("tty: Serialize tcflow() with other tty flow
control changes"), start_tty() was already holding spinlock.

$ git blame c545b66c6922b002~1 drivers/tty/tty_io.c
f9e053dcfc02b drivers/tty/tty_io.c  (Peter Hurley              2014-09-10 15:06:31 -0400  965) void start_tty(struct tty_struct *tty)
f9e053dcfc02b drivers/tty/tty_io.c  (Peter Hurley              2014-09-10 15:06:31 -0400  966) {
f9e053dcfc02b drivers/tty/tty_io.c  (Peter Hurley              2014-09-10 15:06:31 -0400  967)  unsigned long flags;
f9e053dcfc02b drivers/tty/tty_io.c  (Peter Hurley              2014-09-10 15:06:31 -0400  968)
f9e053dcfc02b drivers/tty/tty_io.c  (Peter Hurley              2014-09-10 15:06:31 -0400  969)  spin_lock_irqsave(&tty->flow_lock, flags);
f9e053dcfc02b drivers/tty/tty_io.c  (Peter Hurley              2014-09-10 15:06:31 -0400  970)  __start_tty(tty);
f9e053dcfc02b drivers/tty/tty_io.c  (Peter Hurley              2014-09-10 15:06:31 -0400  971)  spin_unlock_irqrestore(&tty->flow_lock, flags);
f9e053dcfc02b drivers/tty/tty_io.c  (Peter Hurley              2014-09-10 15:06:31 -0400  972) }

Actually, it is commit f9e053dcfc02b0ad ("tty: Serialize tty flow control changes
with flow_lock") that started calling tty->ops->start(tty) from atomic context.

$ git blame f9e053dcfc02b~1 drivers/tty/tty_io.c
^1da177e4c3f4 drivers/char/tty_io.c (Linus Torvalds            2005-04-16 15:20:36 -0700  959) void start_tty(struct tty_struct *tty)
^1da177e4c3f4 drivers/char/tty_io.c (Linus Torvalds            2005-04-16 15:20:36 -0700  960) {
04f378b198da2 drivers/char/tty_io.c (Alan Cox                  2008-04-30 00:53:29 -0700  961)  unsigned long flags;
04f378b198da2 drivers/char/tty_io.c (Alan Cox                  2008-04-30 00:53:29 -0700  962)  spin_lock_irqsave(&tty->ctrl_lock, flags);
04f378b198da2 drivers/char/tty_io.c (Alan Cox                  2008-04-30 00:53:29 -0700  963)  if (!tty->stopped || tty->flow_stopped) {
04f378b198da2 drivers/char/tty_io.c (Alan Cox                  2008-04-30 00:53:29 -0700  964)          spin_unlock_irqrestore(&tty->ctrl_lock, flags);
^1da177e4c3f4 drivers/char/tty_io.c (Linus Torvalds            2005-04-16 15:20:36 -0700  965)          return;
04f378b198da2 drivers/char/tty_io.c (Alan Cox                  2008-04-30 00:53:29 -0700  966)  }
^1da177e4c3f4 drivers/char/tty_io.c (Linus Torvalds            2005-04-16 15:20:36 -0700  967)  tty->stopped = 0;
^1da177e4c3f4 drivers/char/tty_io.c (Linus Torvalds            2005-04-16 15:20:36 -0700  968)  if (tty->link && tty->link->packet) {
^1da177e4c3f4 drivers/char/tty_io.c (Linus Torvalds            2005-04-16 15:20:36 -0700  969)          tty->ctrl_status &= ~TIOCPKT_STOP;
^1da177e4c3f4 drivers/char/tty_io.c (Linus Torvalds            2005-04-16 15:20:36 -0700  970)          tty->ctrl_status |= TIOCPKT_START;
4b19449db074e drivers/char/tty_io.c (Davide Libenzi            2009-03-31 15:24:24 -0700  971)          wake_up_interruptible_poll(&tty->link->read_wait, POLLIN);
^1da177e4c3f4 drivers/char/tty_io.c (Linus Torvalds            2005-04-16 15:20:36 -0700  972)  }
04f378b198da2 drivers/char/tty_io.c (Alan Cox                  2008-04-30 00:53:29 -0700  973)  spin_unlock_irqrestore(&tty->ctrl_lock, flags);
f34d7a5b7010b drivers/char/tty_io.c (Alan Cox                  2008-04-30 00:54:13 -0700  974)  if (tty->ops->start)
f34d7a5b7010b drivers/char/tty_io.c (Alan Cox                  2008-04-30 00:54:13 -0700  975)          (tty->ops->start)(tty);
^1da177e4c3f4 drivers/char/tty_io.c (Linus Torvalds            2005-04-16 15:20:36 -0700  976)  /* If we have a running line discipline it may need kicking */
^1da177e4c3f4 drivers/char/tty_io.c (Linus Torvalds            2005-04-16 15:20:36 -0700  977)  tty_wakeup(tty);
^1da177e4c3f4 drivers/char/tty_io.c (Linus Torvalds            2005-04-16 15:20:36 -0700  978) }

Therefore, I think that bisection will reach f9e053dcfc02b0ad, and I guess that
this bug was not noticed simply because little people tested n_hdlc driver.

Well, how to fix? Introduce a new flag for indicating "starting" state (like drivers/block/loop.c uses Lo_* state) ?
