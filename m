Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D5B3ACBF2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhFRNTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbhFRNTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:19:07 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAEFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 06:16:57 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id y11so1241599qvv.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 06:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=rnZyeR9vGet4GSsiHlvDTfsh5SnCOawKW/arDlMf4Cw=;
        b=A4McDRnWLqJAjS7rCF0vSnH+aY3UBAHfPjafR+E2FSHXlF6daY3WSBSngJ2Xuzklvr
         JNbuLJa1btDoVDTzR8Tv2W46H4Qagn2u5qgXc7Qn2eNy9L6UPyc75CDi76n02fqh+Gvf
         DdoyqM8rDafL1mNARN+DW8PES784VUciB9NpDPE67Oi9ipUq8hJoqf2IwdangqUpmn36
         HnK/w9RJAG7nqNghcMTMdFoqElJd+WBwA7hE7l/se3j4cBYNK5+OW+smKKXeejsRVDWa
         nI1RAzMpD7hD56mPxxwOg45Se7nKs1E6UhTzyVGXxdvqfLTGRhK+ekrJvNLb7DlW8IA2
         90dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rnZyeR9vGet4GSsiHlvDTfsh5SnCOawKW/arDlMf4Cw=;
        b=lFxvpCYGFims+MVrS9TwjXda2nzO11W7d3BWal3MV0P9Nh/RaNflR7YBxFsXvQNZmT
         HjXZh5v537BCLa6N3IWkUy4a+gYhtsyLBa21JtkFVw413C0KxowM0YOfIL4ujUdRNdkX
         fXo0V9EUK9vlDme9KVrcAb/4pIevaECOF7msMM084/lFq3DGHXw8gxhSpG7W3vnPNLGC
         k24ICG1/3nAHD9P/QLQ2R2f6HIVsIJ7kvSgkknOleEFxnt/eu6GY7gnI97RcoWNGsolH
         rf1PU/eVHEBJ5LfISfQSrIrNls1w2W+brD4+lSkuyd8LT7hekwREMMqNWw4L+1ZtmAtV
         Wpmg==
X-Gm-Message-State: AOAM530DAEVT0iN1lSMxEv7a1lh/QFOmPVMp6+nt4D8oaHKc0ZYGE/WW
        F90FlRYIW+IAdZMfFOWBCus=
X-Google-Smtp-Source: ABdhPJzOHzh40Gq7ZMdk9MAkP3QSLdamKYg1MQEvLj+H1OsjChGbfGlCM3O3pmHpkgWU5m4comGvsQ==
X-Received: by 2002:a0c:ab89:: with SMTP id j9mr5660543qvb.54.1624022216401;
        Fri, 18 Jun 2021 06:16:56 -0700 (PDT)
Received: from ?IPv6:2804:14c:482:87bb::1001? ([2804:14c:482:87bb::1001])
        by smtp.gmail.com with ESMTPSA id y18sm5135213qtj.53.2021.06.18.06.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 06:16:55 -0700 (PDT)
Message-ID: <a5e8f78b69ba412a86819a176a44c4f2a2e78ff0.camel@gmail.com>
Subject: Re: REGRESSION: v5.13-rc1 does not boot because of "of/pci: Add
 IORESOURCE_MEM_64 to resource flags for 64-bit memory addresses"
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To:     Domenico Andreoli <domenico.andreoli@linux.com>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Date:   Fri, 18 Jun 2021 10:17:39 -0300
In-Reply-To: <YMyTUv7Jsd89PGci@m4>
References: <YMyTUv7Jsd89PGci@m4>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Domenico,

If I got that correctly, my patche exposes an issue with host bridge
windows. 

There is already a patch approved that should fix the issue:
http://patchwork.ozlabs.org/project/linux-pci/patch/20210614230457.752811-1-punitagrawal@gmail.com/

Please check if it fixes the issue for you (also, if possible give
feedback in the patch thread). 

Best regards,
Leonardo Bras

On Fri, 2021-06-18 at 14:36 +0200, Domenico Andreoli wrote:
> Hi Leonardo,
> 
> Since v5.13-rc1 my NanoPI M4 (arm64 with pcie-attached nvme) does not
> boot any more.
> 
> I could bisect it down to your commit
> 9d57e61bf72336e13e4cd3c31e93ab26266296a8, just
> reverting it from v5.13-rc6 makes the boot happen again.
> 
> The .dts file I use is arch/arm64/boot/dts/rockchip/rk3399-nanopi-
> m4v2.dts.
> 
> This is the output of lspci -vv:
> 
> 00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd RK3399 PCI
> Express Root Port (prog-if 00 [Normal decode])
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 90
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         I/O behind bridge: 00000000-00000fff [size=4K]
>         Memory behind bridge: fa000000-fa0fffff [size=1M]
>         Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
>         BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset-
> FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: <access denied>
>         Kernel driver in use: pcieport
> 
> 01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe
> SSD Controller SM981/PM981/PM983 (prog-if 02 [NVM Express])
>         Subsystem: Samsung Electronics Co Ltd NVMe SSD Controller
> SM981/PM981/PM983
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 89
>         NUMA node: 0
>         Region 0: Memory at fa000000 (64-bit, non-prefetchable)
> [size=16K]
>         Capabilities: <access denied>
>         Kernel driver in use: nvme
>         Kernel modules: nvme
> 
> Is there anything I can do to help you understanding why this is
> happening?
> 
> I apologize for not having bisected it earlier.
> 
> Kind regards,
> Domenico
> 


