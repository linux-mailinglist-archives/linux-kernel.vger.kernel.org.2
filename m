Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E556439CDF6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 10:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhFFICV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 04:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhFFICK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 04:02:10 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA00C061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 01:00:21 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ho18so10373118ejc.8
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 01:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hzXWVYuHPO0HzGbuV38PXs8/wUnrHlukxPMovMMm7Zg=;
        b=jw9zAPJsyisWLgmvBAMUfnjpa9BZs/XmjhHOLnKG7z9NmAkwP95EAGgEf8TPDV4urx
         UEXPJZcOvQ5Au+GxEIT7mfqmhHOnMxmadcLFeuae7zPfhPHGI9LYW3XdxG/TVaDcDtEj
         Jjpjw9QH3KB9AF87+n/mVDaZtu7cwvOHRqi5RemWG2cB6oePpwGP+fgsijjCme2CctMs
         vJpljgMU/aPEG1NXlrHeq2iQUjl/GvEl66/qCkLfUxhN4G8lC++xz8VF6fp/crtL45r7
         NgN4NMei7fsy7CTfTj0rx151SY3Sk3rh8+rsY0luTIWS45KC0aMQMlFFA+TJYmOfSFJO
         tuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hzXWVYuHPO0HzGbuV38PXs8/wUnrHlukxPMovMMm7Zg=;
        b=dQsuQP/ezxO7XaS8ztT1rkOJbfWyHza01/pkl6PUqJv+fARbyAM8r6UV8bQbL+zyWR
         /bx1bBvSHAvcNb7YG6WJ/c7f1zheXaQpkN2Nuy+Shly5oFarqlDEgSDAvvGiBPo+3ouN
         qz/rQYTeKJYnvbJp8EG0eh09tGmGBQoF/Dnnszf/0EU5dgVSmYGEh8fVzW1aD6sX8zMz
         aCo75F7mP15yT+muJQppyfDIST2nbY/WRtcoxcxeT17gOyBzQMkgN1QfJBMhn4+DeR9g
         Tqu0ZO2PtXSKkuPAviTOdEfwZ0p9PsvyCuZSFmfdLz2i+9D8j7XKgMWk75Y5C33qfH8O
         CgDA==
X-Gm-Message-State: AOAM533GBUj0qzim9MVRk5IjjHfDI5WAtEDhFbLaLPNyo05g62iGd9bk
        d6jXjAY51MmtmRz96Xetn08=
X-Google-Smtp-Source: ABdhPJzWwLQ5XZiqEbS8n6pmT3UcJJbIyn4q/cdq4YQvtLEMOuFLVhfEeaZ5f7KpunFtsKSGK9K/JQ==
X-Received: by 2002:a17:907:7b9e:: with SMTP id ne30mr12756492ejc.389.1622966419823;
        Sun, 06 Jun 2021 01:00:19 -0700 (PDT)
Received: from linux.local (host-82-59-55-132.retail.telecomitalia.it. [82.59.55.132])
        by smtp.gmail.com with ESMTPSA id v1sm4965624ejw.117.2021.06.06.01.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 01:00:19 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wenli Looi <wlooi@ucalgary.ca>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Fix uninitialized variable
Date:   Sun, 06 Jun 2021 10:00:18 +0200
Message-ID: <10029109.FgdUXNWx4t@linux.local>
In-Reply-To: <CAKe_nd2q8caqND=z9Pq7Me_BtyuCd2-Nb_xyepsjDkaPkC8Few@mail.gmail.com>
References: <20210606070021.116284-1-wlooi@ucalgary.ca> <YLx1oWQAFPYIFRkF@kroah.com> <CAKe_nd2q8caqND=z9Pq7Me_BtyuCd2-Nb_xyepsjDkaPkC8Few@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, June 6, 2021 9:51:35 AM CEST Wenli Looi wrote:
> On Sun, Jun 6, 2021 at 12:13 AM Greg Kroah-Hartman
> 
> <gregkh@linuxfoundation.org> wrote:
> > On Sun, Jun 06, 2021 at 12:00:21AM -0700, Wenli Looi wrote:
> > > Uninitialized struct with invalid pointer causes BUG and prevents access
> > > point from working. Access point works once I apply this patch.
> > > 
> > > https://forum.armbian.com/topic/14727-wifi-ap-kernel-bug-in-kernel-5444/
> > > has more details.
> > > 
> > > Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
> > > ---
> > > 
> > >  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > > b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c index 2fb80b6eb..
7308e1185
> > > 100644
> > > --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > > +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > > @@ -2384,7 +2384,7 @@ void rtw_cfg80211_indicate_sta_assoc(struct 
adapter *padapter,
> > > u8 *pmgmt_frame,> > 
> > >       DBG_871X(FUNC_ADPT_FMT"\n", FUNC_ADPT_ARG(padapter));
> > >       
> > >       {
> > > 
> > > -             struct station_info sinfo;
> > > +             struct station_info sinfo = {};
> > 
> > What caused this bug to show up?  Did it happen from some other commit?
> > 
> > Are you sure that all of the fields are being cleared properly here,
> > what about any "holes" in the structure?
> > 
> > thanks,
> > greg k-h
> 
> I believe this bug has been present since the driver was added to
> staging:
> https://github.com/torvalds/linux/commit/
554c0a3abf216c991c5ebddcdb2c08689ecd290b
> 
> It's probably not necessary to zero the entire struct, only
> sinfo->pertid, which causes problems with the code here:
> https://github.com/torvalds/linux/blob/
f5b6eb1e018203913dfefcf6fa988649ad11ad6e/net/wire
> less/nl80211.c#L5919
> 
> You can see the following proposed OpenWrt patch
> (700-wifi-8723bs-ap-bugfix.patch in
> https://github.com/openwrt/openwrt/pull/4053/files) which sets
> sinfo.pertid = 0; instead of zeroing the struct.
> 
> Looking at similar code in a non-staging driver, we can see that the
> code there zeros the struct using kzalloc():
> https://github.com/torvalds/linux/blob/
f5b6eb1e018203913dfefcf6fa988649ad11ad6e/drivers/
> net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c#L6064
> 
> Do you think kzalloc() would be preferable?
>
You cannot use kzalloc there: 'sinfo' is instantiated automatically on the 
stack. The example you took had a pointer to the struct. 

Fabio
> 
> Sorry, I'm not familiar with "holes" in the struct.




