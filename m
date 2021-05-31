Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23B83954C0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 06:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhEaEnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 00:43:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42746 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229475AbhEaEmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 00:42:52 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14V4bW8G010223;
        Mon, 31 May 2021 04:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=bi9DxGZAxkKZrMq89FwAaWRgj9tNTfG5Pz62LsoLm9E=;
 b=VfJIjkM8i8gR5iMzqMMWZsoYgoyChLXeXVB8IvVyrsMMuDA43ME2T59rsHtxZJz05SpA
 XkJXsyQjJH9I1VZ0jKoyCmz6aWuPaS4nAFJv8JVbPZ1leGm+t0bttRB1y7jmxIemJ/Mf
 WFQDQzsAnmkJHVeXSnscP23aXLP/P9zBnDWPHFEX2fAhB+MIxd28pwLxh82X+SNBJMMN
 Jhv9D7UKEhClOC+lL55BwjGSB1A6Ze+c/2vFjgOOJMgFbtzThc44JlOpqXdBfiMnmpjI
 14W0wisxLHPCvNcaLLFY0gc+/oLFzxu2K+R7z0yCKBvM4BfBWCoMORwOl3DQlg6K5Y7E UQ== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38ucd10kb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 04:40:33 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14V4eW5E194782;
        Mon, 31 May 2021 04:40:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38uycq2aa0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 04:40:32 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14V4eWSH194760;
        Mon, 31 May 2021 04:40:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 38uycq2a99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 04:40:32 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14V4eTVm023366;
        Mon, 31 May 2021 04:40:29 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 30 May 2021 21:40:29 -0700
Date:   Mon, 31 May 2021 07:40:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com
Subject: Re: [PATCH] ALSA: control led: fix memory leak in
 snd_ctl_led_register
Message-ID: <20210531044022.GU24442@kadam>
References: <20210528131757.2269989-1-mudongliangabcd@gmail.com>
 <20210528133309.GR24442@kadam>
 <CAD-N9QVWcEJjoziA6HVoQiUueVaKqAJS5Et60zvCvuUE7e6=gg@mail.gmail.com>
 <20210528140500.GS24442@kadam>
 <A622EB84-DC4A-47A4-A828-CE6D25DC92EB@gmail.com>
 <CAD-N9QVjhDDJxRnNrDzwt05BNijr1o11nE8xjvq8GrakEJ8EuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD-N9QVjhDDJxRnNrDzwt05BNijr1o11nE8xjvq8GrakEJ8EuQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: RKERy0vMBCakP9vaI4pKWWaxjuNJMYTS
X-Proofpoint-ORIG-GUID: RKERy0vMBCakP9vaI4pKWWaxjuNJMYTS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 11:03:36AM +0800, Dongliang Mu wrote:
> On Sat, May 29, 2021 at 5:35 AM 慕冬亮 <mudongliangabcd@gmail.com> wrote:
> >
> >
> >
> > > On May 28, 2021, at 10:05 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > On Fri, May 28, 2021 at 09:50:49PM +0800, Dongliang Mu wrote:
> > >>
> > >> Can you please give some advise on how to fix this WARN issue?
> > >
> > > But it feels like it spoils the fun if I write the commit...  Anyway:
> >
> > It’s fine. I am still in the learning process. It’s also good to learn experience by comparing your patch and my patch.
> >
> > >
> > > regards,
> > > dan carpenter
> > >
> > > diff --git a/sound/core/control_led.c b/sound/core/control_led.c
> > > index 25f57c14f294..dd357abc1b58 100644
> > > --- a/sound/core/control_led.c
> > > +++ b/sound/core/control_led.c
> > > @@ -740,6 +740,7 @@ static int __init snd_ctl_led_init(void)
> > >                       for (; group > 0; group--) {
> > >                               led = &snd_ctl_leds[group - 1];
> > >                               device_del(&led->dev);
> > > +                             device_put(&led->dev);
> > >                       }
> > >                       device_del(&snd_ctl_led_dev);
> > >                       return -ENOMEM;
> > > @@ -768,6 +769,7 @@ static void __exit snd_ctl_led_exit(void)
> > >       for (group = 0; group < MAX_LED; group++) {
> > >               led = &snd_ctl_leds[group];
> > >               device_del(&led->dev);
> > > +             device_put(&led->dev);
> > >       }
> > >       device_del(&snd_ctl_led_dev);
> > >       snd_ctl_led_clean(NULL);
> 
> Hi Dan,
> 
> I tried this patch, and it still triggers the memleak.

Did your patch fix the leak?  Because my patch should have been
equivalent except for it fixes an additional leak in the snd_ctl_led_init()
error path.

> My
> understanding is that the device object is already freed in the
> snd_ctl_led_sysfs_remove.
> 

"Already freed"?  Is it a memleak or is it a double free???  I probably
should have read the syzbot email on this...  But you didn't include
a link to it or a reported-by tag so I don't have a way to look at the
actual bug.

I did fix a bug, though...  Just not the one from the report I guess.
Please send a link to the bug report so I can look at that.  ;)

regards,
dan carpenter

