Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3313EFA69
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 07:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbhHRF6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 01:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbhHRF6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 01:58:51 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC84C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 22:58:16 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id dj8so1334972edb.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 22:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+33Dw5Q2efUACOK/im6UMmJQhcP/Gv+10S0CqUotcBU=;
        b=L8BDnQT8dSjC6pPMY2/gI8Jhl7qL76VLTYo/0QvFNVIV9VPzSIu8/jRZxL+zo9A7m8
         C5NgGPCZUa3Iawy8NaBcC9H8xvZHnjIyPFZmK0kt7EeZKt2F6KvjbjHdNBJLbQJMbuuo
         ML3VUTNLeLiM4ui2pDgoAXDJeAjrkkAQ0OKoHNXBEd4sBrH+63swSUajvHuMNG1z+M1J
         zPj+bJ5QS5XH816OZ8/nuMJ70P/bwg3jjGO6SjzGEHuNjOaJckjUiuIXXL+mmcSu/aLn
         kRc2UbzB4yuaD95qFCW/vfgvVhSn+zsGQckHXuP10wj5j5G9oAybQxtUg5g3bxgyi4K4
         6Wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+33Dw5Q2efUACOK/im6UMmJQhcP/Gv+10S0CqUotcBU=;
        b=ZOFnE5axRT87RC7TC2Cjf4lwCtJNt9lA56Eah4lXy2u9mK/EAYT/3Cm7/WvU8P1ffc
         2EPHX6BFtvcsnSVyNFrgd5hMCxlvqOAeqz1FltxgCPtUUKTrgG0K8Yd9Zvx/NFhErnSO
         Si41Uausg6gjgsZx/XPOFoM4f7hIj7ThoYKeJiBdNIYubZZX2O8Ao9IRnWZUtV1ohx6t
         jA8L0xPOnp/gf8oIeGXqieh23GdtYZTIVlDjHQC1X3d4Uc00D/PgbZx6gOWKbldDR48i
         chAzmnnsZtXVt5j5VkhyVk/5AqXcNLNFfc1xFU1z5SRrYbYZk5DfV4QnnbiF1dajIiSA
         WghQ==
X-Gm-Message-State: AOAM532f0TEPLDu+uL+tOnM4VFUcWRsWkCNMkLE1p1Cxoggp8MBPfyFG
        2gMAKBI1drcJSDaFc9jd7IM=
X-Google-Smtp-Source: ABdhPJxzrUvtdM8TTbZsSRVUa5R10cl2QYnbxhaxsiUqRat7sQKbfrhTONE38HGIM8w0JGD9TM3i8g==
X-Received: by 2002:aa7:d404:: with SMTP id z4mr8025699edq.255.1629266295133;
        Tue, 17 Aug 2021 22:58:15 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id nd14sm1515245ejc.113.2021.08.17.22.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 22:58:14 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aakash Hemadri <aakashhemadri123@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] staging: rtl8732bs: Fix sparse warnings
Date:   Wed, 18 Aug 2021 07:58:13 +0200
Message-ID: <7025395.Gq2ipLbEtH@localhost.localdomain>
In-Reply-To: <22319634.U67b3Ei0OZ@localhost.localdomain>
References: <cover.1629135143.git.aakashhemadri123@gmail.com> <22319634.U67b3Ei0OZ@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 16, 2021 8:48:48 PM CEST Fabio M. De Francesco wrote:
> On Monday, August 16, 2021 7:35:05 PM CEST Aakash Hemadri wrote:
> > This patchset fixes the below sparse warnings
> >
> > [...]
> >
> This warnings have been fixed time ago against staging-testing:
> please see commit aef1c966a364.

Hi Aakash,

I see at least two of your messages never made it to
linux-staging list because the address is incorrect (you did not write in CC
linux-staging@lists.linux.dev, instead you used the nonexistent
linux-staging@vger.kernel.org):

https://lore.kernel.org/lkml/20210818044200.tvpr4j5vcaimexsn@xps.yggdrasil/
https://lore.kernel.org/lkml/20210818044049.yd7tnjvj3j4j3ddb@xps.yggdrasil/

Please, send them again to the correct address.

Thanks,

Fabio


