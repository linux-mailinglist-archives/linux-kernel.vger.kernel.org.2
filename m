Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC863B5FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 16:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhF1OUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 10:20:19 -0400
Received: from netrider.rowland.org ([192.131.102.5]:47827 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S232093AbhF1OUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 10:20:17 -0400
Received: (qmail 657640 invoked by uid 1000); 28 Jun 2021 10:17:51 -0400
Date:   Mon, 28 Jun 2021 10:17:51 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+e2eae5639e7203360018@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "guido.kiener@rohde-schwarz.com" <guido.kiener@rohde-schwarz.com>,
        "dpenkler@gmail.com" <dpenkler@gmail.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        USB list <linux-usb@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [syzbot] INFO: rcu detected stall in tx
Message-ID: <20210628141751.GB656159@rowland.harvard.edu>
References: <000000000000a9b79905c04e25a0@google.com>
 <CACT4Y+aF64oNZD7Vd04bj+KfBU5GqVobCbRPp2-x_Z6dEr8d3A@mail.gmail.com>
 <BL1PR11MB5478572825796B0F04E1E1FDFF039@BL1PR11MB5478.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB5478572825796B0F04E1E1FDFF039@BL1PR11MB5478.namprd11.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 06:38:37AM +0000, Zhang, Qiang wrote:
> 
> 
> ________________________________________
> From: Dmitry Vyukov <dvyukov@google.com>
> Sent: Monday, 19 April 2021 15:27
> To: syzbot; Greg Kroah-Hartman; guido.kiener@rohde-schwarz.com; dpenkler@gmail.com; lee.jones@linaro.org; USB list
> Cc: bp@alien8.de; dwmw@amazon.co.uk; hpa@zytor.com; linux-kernel@vger.kernel.org; luto@kernel.org; mingo@redhat.com; syzkaller-bugs@googlegroups.com; tglx@linutronix.de; x86@kernel.org
> Subject: Re: [syzbot] INFO: rcu detected stall in tx
> 
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Mon, Apr 19, 2021 at 9:19 AM syzbot
> <syzbot+e2eae5639e7203360018@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    50987bec Merge tag 'trace-v5.12-rc7' of git://git.kernel.o..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1065c5fcd00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=398c4d0fe6f66e68
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e2eae5639e7203360018
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+e2eae5639e7203360018@syzkaller.appspotmail.com
> >
> > usbtmc 5-1:0.0: unknown status received: -71
> > usbtmc 3-1:0.0: unknown status received: -71
> > usbtmc 5-1:0.0: unknown status received: -71
> 
> >The log shows an infinite stream of these before the stall, so I
> >assume it's an infinite loop in usbtmc.
> >+usbtmc maintainers
> >
> >[  370.171634][    C0] usbtmc 6-1:0.0: unknown status received: >-71
> >[  370.177799][    C1] usbtmc 3-1:0.0: unknown status received: >-71

> This seems like a long time in the following cycle,  when the callback function usbtmc_interrupt() find unknown status error, it will submit urb again. the urb may be insert  urbp_list.
> due to the dummy_timer() be called in bh-disable. 
> This will result in the RCU reading critical area not exiting for a long time (note: bh_disable/enable, preempt_disable/enable is regarded as the RCU critical reading area ), and prevent rcu_preempt kthread be schedule and running.

> Whether to return directly when we find the urb status is unknown error?

Yes.

> diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
> index 74d5a9c5238a..39d44339c03f 100644
> --- a/drivers/usb/class/usbtmc.c
> +++ b/drivers/usb/class/usbtmc.c
> @@ -2335,6 +2335,7 @@ static void usbtmc_interrupt(struct urb *urb)
>                 return;
>         default:
>                 dev_err(dev, "unknown status received: %d\n", status);
> +               return;
>         }
>  exit:
>         rv = usb_submit_urb(urb, GFP_ATOMIC);

This is the right thing to do.  In fact, you should also change the code 
above this.  There's no real need for special handling of the 
-ECONNRESET, -ENOENT, ..., -EPIPE codes, since the driver will do the 
same thing no matter what the code is.

Alan Stern
