Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D01635A0A2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 16:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbhDIOFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 10:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbhDIOFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 10:05:01 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8EDC061760;
        Fri,  9 Apr 2021 07:04:47 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d11so1865503wro.13;
        Fri, 09 Apr 2021 07:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=A5LE/nloZgweDANjgJoolUS7WHVqsJjergOyixsI/cI=;
        b=eHDuuA1jsvsnNbIzLoDqBKfJnpBEczt/OAI62ifJP1GZx/ffAQva9aILVjToc6Q7Kw
         isK3Z+23X3F0aEZC8OMhr+FKGPv9z7FoyEcnRnN6ZEHCE6T+3mBXI4c9jhLyNh0zIVEc
         QCPZyrBlwZhmnsJY724Lr7LIwUBGmnGRoaMwpp47LY+dBwWtulNkNh4295BU9mbXz0G+
         VWsR37+FccsY285RsKGer8QUFi9wPMqdQ67Q3Z8isgrq3BgQj0HG5UFa16ftnWzZ7FtX
         /YJCdv/XtFwlabT/wM71Y6C+3Yh0cqhWroA0ZimFvOcyXY+ElEZ10nohyMd1VkaoxEJm
         e9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=A5LE/nloZgweDANjgJoolUS7WHVqsJjergOyixsI/cI=;
        b=PlWayA77Zp/ATlKAeM8SzzTg9qraEeUgqgeuO1WvBdGs8SIvKCqydrH0nKWD4pqQNY
         mYCxtcjE1OeMr41KKEV84oGdlQl5HcRythBy9PdquAUNOoavCHmrVa5ZVjR3JCRfOBcE
         61cUPG25mEZErPxS3SCwQ0cBdb2yXwf0TA1bVbwXplXNAkqlpo2lbK51C0SpWE89m3nL
         hCOpbE7q0p45uFTXSzsK2MmkYfPB/s0RRiiNlwPX22nLfBTeT+B2vsbY2LQSzfV6MTKn
         9+p6X1OK5yw2t7+blokvpfce8W0UoUj5KrrvWdQqcFdfZdWKZ1Quqrfhfr2I/eBYQ4na
         6X+g==
X-Gm-Message-State: AOAM533ibhxOulGP32jg6AeBiFlEssArE2tSB+aCzZU1boKARp/zKaGj
        OYnFFA6aMYA/fw9TO41JlKoo3o6N5GEBAg==
X-Google-Smtp-Source: ABdhPJwcmlSrUaYfMLzkXKWp9KmiEB81whxFSpWovAVAGzDVLAu4+hzxt1MgdE1Jm9UeNJIkydxRxw==
X-Received: by 2002:a5d:6d48:: with SMTP id k8mr18070980wri.93.1617977086441;
        Fri, 09 Apr 2021 07:04:46 -0700 (PDT)
Received: from 192.168.10.5 ([39.46.65.172])
        by smtp.gmail.com with ESMTPSA id z15sm4951029wrw.38.2021.04.09.07.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 07:04:46 -0700 (PDT)
Message-ID: <772123d6be10ec8d299a605029ef95003a1513ec.camel@gmail.com>
Subject: Re: New Defects reported by Coverity Scan for linux-next weekly scan
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     scan-admin@coverity.com, colin.king@canonical.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     musamaanjum@gmail.com
Date:   Fri, 09 Apr 2021 19:04:41 +0500
In-Reply-To: <606f39c2c377f_1aed562adb26462f5449492@prd-scan-dashboard-0.mail>
References: <606f39c2c377f_1aed562adb26462f5449492@prd-scan-dashboard-0.mail>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-04-08 at 17:13 +0000, scan-admin@coverity.com wrote:
> ** CID 1503714:    (DEADCODE)
> /drivers/staging/rtl8723bs/os_dep/ioctl_linux.c: 367 in wpa_set_auth_algs()
> /drivers/staging/rtl8723bs/os_dep/ioctl_linux.c: 357 in wpa_set_auth_algs()
> 
> 
> ________________________________________________________________________________________________________
> *** CID 1503714:    (DEADCODE)
> /drivers/staging/rtl8723bs/os_dep/ioctl_linux.c: 367 in wpa_set_auth_algs()
> 361     		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
> 362     
> 363     		padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeShared;
> 364     		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Shared;
> 365     	} else if (value & WLAN_AUTH_OPEN) {
> 366     		/* padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled; */
> > > >     CID 1503714:    (DEADCODE)
> > > >     Execution cannot reach this statement: "if (padapter->securitypriv....".
> 367     		if (padapter->securitypriv.ndisauthtype < Ndis802_11AuthModeWPAPSK) {
> 368     			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
> 369     			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
> 370     		}
> 371     	} else {
> 372     		ret = -EINVAL;
> /drivers/staging/rtl8723bs/os_dep/ioctl_linux.c: 357 in wpa_set_auth_algs()
> 351     static int wpa_set_auth_algs(struct net_device *dev, u32 value)
> 352     {
> 353     	struct adapter *padapter = rtw_netdev_priv(dev);
> 354     	int ret = 0;
> 355     
> 356     	if ((value & WLAN_AUTH_SHARED_KEY) && (value & WLAN_AUTH_OPEN)) {

The value of WLAN_AUTH_OPEN macro is 0 and it is being treated as if
is a bit number. Two conditions in this function never execute. It
seems like a crucial bug. Anyone looking into it?

> > > >     CID 1503714:    (DEADCODE)
> > > >     Execution cannot reach this statement: "padapter->securitypriv.ndis...".
> 357     		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
> 358     		padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeAutoSwitch;
> 359     		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Auto;
> 360     	} else if (value & WLAN_AUTH_SHARED_KEY)	{
> 361     		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
> 362     
> 
> ** CID 1487894:  Null pointer dereferences  (FORWARD_NULL)
> /net/ipv6/route.c: 5209 in ip6_route_multipath_add()


