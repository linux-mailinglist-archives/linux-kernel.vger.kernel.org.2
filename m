Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710393955B5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhEaHGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:06:18 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:63672 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230104AbhEaHGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:06:17 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14V71LCx018282;
        Mon, 31 May 2021 07:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=qvoKJptC2ahk0qShqs9BtNk99vLgP96BCsP8aKRRTUY=;
 b=IhrILeOHaf21U7vxeXhCaGsesmLRntotCA1gnvduPCcuFj/TlEwLvFDyRF5UvCiJXlSy
 9ez8KoI9niejKUxzTiMCQ6Gr4jf3kPF34x2a5Z2CEiE5bSlP2FBbXUlhoHIYvgvcztAR
 6s9wXBiMO2eIfaXyejtj1gxGB7ijyFC2jEUEKjygUqlNfRkbOEd7ImLAMJc82u4oShCG
 XdS5FPc/5oDWHz/ZV15VM7PrpOQPlbOSeC/9XD9I4ScDDbJdcysX/4XW8flXeZoDY35m
 aXqhr4T4YX2w/EMpmiMJ+j7tKNB9UeuoNAnLkgzQ0uI4wfgf8AS/NSoVWgfNxPBsuCyU EQ== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 38vtymg027-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 07:03:50 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14V73nxO192652;
        Mon, 31 May 2021 07:03:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38uaqv6224-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 07:03:49 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14V73mK1192633;
        Mon, 31 May 2021 07:03:48 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 38uaqv621u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 07:03:48 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14V73jAS001775;
        Mon, 31 May 2021 07:03:46 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 31 May 2021 00:03:44 -0700
Date:   Mon, 31 May 2021 10:03:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com
Subject: Re: [PATCH] ALSA: control led: fix memory leak in
 snd_ctl_led_register
Message-ID: <20210531070337.GV24442@kadam>
References: <20210528131757.2269989-1-mudongliangabcd@gmail.com>
 <20210528133309.GR24442@kadam>
 <CAD-N9QVWcEJjoziA6HVoQiUueVaKqAJS5Et60zvCvuUE7e6=gg@mail.gmail.com>
 <20210528140500.GS24442@kadam>
 <A622EB84-DC4A-47A4-A828-CE6D25DC92EB@gmail.com>
 <CAD-N9QVjhDDJxRnNrDzwt05BNijr1o11nE8xjvq8GrakEJ8EuQ@mail.gmail.com>
 <20210531044022.GU24442@kadam>
 <CAD-N9QWBBP6_Wwi4z3e4yJM-tS54=1=CcvAA+2__Qj8NsTLq9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD-N9QWBBP6_Wwi4z3e4yJM-tS54=1=CcvAA+2__Qj8NsTLq9g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: _Gq3qF_EJaeG1F0E0HDttu6e7rzxnp-J
X-Proofpoint-ORIG-GUID: _Gq3qF_EJaeG1F0E0HDttu6e7rzxnp-J
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 02:20:37PM +0800, Dongliang Mu wrote:
> On Mon, May 31, 2021 at 12:40 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Mon, May 31, 2021 at 11:03:36AM +0800, Dongliang Mu wrote:
> > > On Sat, May 29, 2021 at 5:35 AM 慕冬亮 <mudongliangabcd@gmail.com> wrote:
> > > >
> > > >
> > > >
> > > > > On May 28, 2021, at 10:05 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > > >
> > > > > On Fri, May 28, 2021 at 09:50:49PM +0800, Dongliang Mu wrote:
> > > > >>
> > > > >> Can you please give some advise on how to fix this WARN issue?
> > > > >
> > > > > But it feels like it spoils the fun if I write the commit...  Anyway:
> > > >
> > > > It’s fine. I am still in the learning process. It’s also good to learn experience by comparing your patch and my patch.
> > > >
> > > > >
> > > > > regards,
> > > > > dan carpenter
> > > > >
> > > > > diff --git a/sound/core/control_led.c b/sound/core/control_led.c
> > > > > index 25f57c14f294..dd357abc1b58 100644
> > > > > --- a/sound/core/control_led.c
> > > > > +++ b/sound/core/control_led.c
> > > > > @@ -740,6 +740,7 @@ static int __init snd_ctl_led_init(void)
> > > > >                       for (; group > 0; group--) {
> > > > >                               led = &snd_ctl_leds[group - 1];
> > > > >                               device_del(&led->dev);
> > > > > +                             device_put(&led->dev);
> > > > >                       }
> > > > >                       device_del(&snd_ctl_led_dev);
> > > > >                       return -ENOMEM;
> > > > > @@ -768,6 +769,7 @@ static void __exit snd_ctl_led_exit(void)
> > > > >       for (group = 0; group < MAX_LED; group++) {
> > > > >               led = &snd_ctl_leds[group];
> > > > >               device_del(&led->dev);
> > > > > +             device_put(&led->dev);
> > > > >       }
> > > > >       device_del(&snd_ctl_led_dev);
> > > > >       snd_ctl_led_clean(NULL);
> > >
> > > Hi Dan,
> > >
> > > I tried this patch, and it still triggers the memleak.
> >
> > Did your patch fix the leak?  Because my patch should have been
> > equivalent except for it fixes an additional leak in the snd_ctl_led_init()
> > error path.
> 
> The syzbot link is [1]. I have tested my patch in the syzbot dashboard
> and my local workspace.
> 
> I think the reason why your patch did not work should be
> led_card(struct snd_ctl_led_card) is already freed before returning in
> snd_ctl_led_sysfs_remove, rather than led(struct snd_ctl_led). See the
> implementation of snd_ctl_led_sysfs_remove for some details. Please
> correct me if I make any mistakes.
> 
> static void snd_ctl_led_sysfs_remove(struct snd_card *card)
> {
>         unsigned int group;
>         struct snd_ctl_led_card *led_card;
>         struct snd_ctl_led *led;
>         char link_name[32];
> 
>         for (group = 0; group < MAX_LED; group++) {
>                 led = &snd_ctl_leds[group];
>                 led_card = led->cards[card->number];
>                 if (!led_card)
>                         continue;
>                 snprintf(link_name, sizeof(link_name), "led-%s", led->name);
>                 sysfs_remove_link(&card->ctl_dev.kobj, link_name);
>                 sysfs_remove_link(&led_card->dev.kobj, "card");
>                 device_del(&led_card->dev);
>                 put_device(&led_card->dev);
>                 kfree(led_card);
>                 led->cards[card->number] = NULL;
>         }
> }

This is frustrating to look at because it's not a diff so it doesn't
show what you changed.  I think you are saying that you added the
put_device(&led_card->dev);.  That's true.  There are some other leaks
as well.  We should just fix them all.  Use device_unregister() because
it's cleaner.

If both device_initialize() and device_add() succeed then call
device_unregister() to unwind.

diff --git a/sound/core/control_led.c b/sound/core/control_led.c
index 25f57c14f294..561fe45e4449 100644
--- a/sound/core/control_led.c
+++ b/sound/core/control_led.c
@@ -700,7 +700,7 @@ static void snd_ctl_led_sysfs_remove(struct snd_card *card)
 		snprintf(link_name, sizeof(link_name), "led-%s", led->name);
 		sysfs_remove_link(&card->ctl_dev.kobj, link_name);
 		sysfs_remove_link(&led_card->dev.kobj, "card");
-		device_del(&led_card->dev);
+		device_unregister(&led_card->dev);
 		kfree(led_card);
 		led->cards[card->number] = NULL;
 	}
@@ -739,9 +739,9 @@ static int __init snd_ctl_led_init(void)
 			put_device(&led->dev);
 			for (; group > 0; group--) {
 				led = &snd_ctl_leds[group - 1];
-				device_del(&led->dev);
+				device_unregister(&led->dev);
 			}
-			device_del(&snd_ctl_led_dev);
+			device_unregister(&snd_ctl_led_dev);
 			return -ENOMEM;
 		}
 	}
@@ -767,9 +767,9 @@ static void __exit snd_ctl_led_exit(void)
 	}
 	for (group = 0; group < MAX_LED; group++) {
 		led = &snd_ctl_leds[group];
-		device_del(&led->dev);
+		device_unregister(&led->dev);
 	}
-	device_del(&snd_ctl_led_dev);
+	device_unregister(&snd_ctl_led_dev);
 	snd_ctl_led_clean(NULL);
 }
 
