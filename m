Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760153388AA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhCLJ3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbhCLJ25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:28:57 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C23C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:28:57 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id r17so52015958ejy.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/zobFxt/KHNmEiwBybS7/6uzHFLs2BnS4di3FIHlgrk=;
        b=QvUZg/pvhxSNxUUfg0ARyXJPc/CZqAZa08TLxZF1pXSJnLB8BvDmFdIdLQHsAsmchO
         N4pLJ1gb432ZT+JLlWaaa/jV8MCDBHN3dSRvrOely1u/gZ3y3XGM27pFdgxmC7rfIZz3
         pKiHa1n8t1MCEN6OSi++/B+LgaXEfnMyDP+ddL76MAwgFcd5sHnQvQwk+5zPKkBDsE0N
         JAk25QNflImEKdBzM9jCkP5UL+wX3HZdYkCq/+7MGxwGdpYUl8414jRUg17GF79Z3tZa
         x0ImmdVMTEENltRgA9XKf8Uholi/ob/A6xBu1fuZ+HQ3DIbCpwiteIAb9hDCRzvyFcfk
         Wisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/zobFxt/KHNmEiwBybS7/6uzHFLs2BnS4di3FIHlgrk=;
        b=I/ieHNeKJEMELrv+1Er+0UOiFMX2qNfADxVLar3lT63Qj+2QfZwLmjCzq9ENRjgu42
         HkeCHxTa4ayaXW4HUXYlxAfNjktsYybJqtcd8RvR/zCItn1A8bFg/nz6pYQaOQROrot8
         wydMPgGHSERgUgvCx2SkwZ+99NzwH51pBGUHKqyWFK1BfOoV6A5S/Be8x3LIhZiclyfm
         HBrvTDTzDrPPLhp5HPyTUQSrsmS8i9I3CzPD/9FOFU0dthcHcWmaTk29Yj+6hk8ZP/Bf
         GAc/p3A8o+cO7DzfFk0cj3Hb2RrcMTmkHI6gPCr8LK/kgVntaRoTPMnTWtV4/bvr9+29
         HLZw==
X-Gm-Message-State: AOAM530QGjuZtDx3CHokDOSfl5uh0CBQQWbIbT+p8dVhDpwxU/+TNzRz
        BloGuYb1A5QpuKqIRxSwj9ssS9+FUGY=
X-Google-Smtp-Source: ABdhPJzJB3yXVE98QRo1z2ka8YM2BoBfhjQRht5VmeYW+krv/XCRrfIkGM7HoCKrA4XcsLTsE+ducA==
X-Received: by 2002:a17:907:7684:: with SMTP id jv4mr7712752ejc.231.1615541335863;
        Fri, 12 Mar 2021 01:28:55 -0800 (PST)
Received: from BV030612LT ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id k26sm2510835ejk.29.2021.03.12.01.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:28:55 -0800 (PST)
Date:   Fri, 12 Mar 2021 11:28:53 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH 1/1] ARM: owl: Add Actions Semi Owl S500 SoC machine
Message-ID: <20210312092853.GA931435@BV030612LT>
References: <c560f4c188e39c4100e330ed4bc2d277c5ad6905.1615490186.git.cristian.ciocaltea@gmail.com>
 <47295735-2792-a517-b96a-a00a68496846@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47295735-2792-a517-b96a-a00a68496846@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Fri, Mar 12, 2021 at 09:39:31AM +0100, Andreas Färber wrote:
> Hi Cristian,
> 
> On 11.03.21 20:19, Cristian Ciocaltea wrote:
> > Add machine entry for the S500 variant of the Actions Semi Owl SoCs
> > family.
> > 
> > For the moment the only purpose is to provide the system serial
> > information which will be used by the Owl Ethernet MAC driver to
> > generate a stable MAC address.
> 
> Can't that be done in either a sys_soc driver or U-Boot?

I will look first at the sys_soc driver approach.

I haven't started working on the U-Boot side yet, but I'm planning to do
so as soon as possible. Last time when I checked, there was some initial
support only for the S700 and S900 SoCs, but I will do my best to add
also the S500 to the list.

Thanks,
Cristi

> Regards,
> Andreas
> 
> -- 
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> GF: Felix Imendörffer
> HRB 36809 (AG Nürnberg)
