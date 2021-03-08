Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9417D331506
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCHRji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhCHRjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:39:06 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5F6C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 09:39:06 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id kx1so17455pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 09:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hUCvK/I+zgUewNk8E2scyHBkcJ9RAyOMA/sKBoxnDw4=;
        b=fHXmGRBN1mCiws4dt5VljccU5Kx8Q2GwWwzjmlREjQv9f31rgqothtHBT2MZCaAGP8
         x+m4Ra8lvqyZIXh57Ku8/zGff/aucTCiELnx6RmIqQaEqUDeZ2eqd1mdOSbPxKtZUt7L
         hGgUS0n2KQ16nEwyVGaGuyx/FwFbla8rIHJX/SCMge2wntOR+40FI691JTb7MqdFC0XG
         6PmH0sz1zzWZJ5tvnUT2vWsiYmKArqehM2VwzWnNXRxpRTSMeVLiJXZYYz6EqhwdcwQ5
         5y86NSDN9kGCc8wMghxt2gGaD4vvK1sCAktXgmjHACGgARLMPKtvoosmSnA5Nqg86Vcs
         SHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hUCvK/I+zgUewNk8E2scyHBkcJ9RAyOMA/sKBoxnDw4=;
        b=R0zotMEsuWCCalPLxIr1KDd427AaQoqYadHB4Elp4Z6J4oxURVCEQIRilPgZvvQ6j+
         QMwbjg8cCZ+2xEJ9mqk2y10mR7lsGeBu1X/Lzc3FRsNs1IMriQde2vkYwaWgV32BHyQ0
         glOvqMn1wJDqC7EIumD4wmrQSQgCeYdVLDgYkUI1maXXbK0EfknUbWiH4sYGop73PRu9
         n/eJgPs8ACQ7aPKPNbOfwxeFiEoYFCsUX3WAWPsQcx4Hi/RkMW4B0GdNuhQSM9qVIyHy
         SwsE+WjD/l/u+zLGoY+0S+291GKtadHsg238IqCMkQnbWmrnayWtlUK8yOXDIDMyRFYs
         4SiA==
X-Gm-Message-State: AOAM533qxni3/qi/370Z/Jpxf2cj7X1FpT5iTxDymggYmeOpQUf0GiCS
        b3CGq2MhwBSusI8MNZ9rlzX0Tw==
X-Google-Smtp-Source: ABdhPJzC2/eu6E4CQbyADDmbk/3ijOnoW08IMivrr8a2H9j48dNkZ2wVa6e6b3tyZbILc7r8PR300w==
X-Received: by 2002:a17:90a:658b:: with SMTP id k11mr16781689pjj.92.1615225145512;
        Mon, 08 Mar 2021 09:39:05 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id t18sm5226942pfq.147.2021.03.08.09.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:39:05 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: amlogic: add support for the Minix NEO U9-H
Date:   Mon,  8 Mar 2021 09:39:03 -0800
Message-Id: <161522513396.14471.6052884995015954642.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210201210508.1528-1-christianshewitt@gmail.com>
References: <20210201210508.1528-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Feb 2021 21:05:07 +0000, Christian Hewitt wrote:
> The Minix NEO U9-H is a small form-factor Android STB based on the
> Amlogic Q200 reference board with an S912-H chip.

Applied, thanks!

[1/2] dt-bindings: arm: amlogic: add support for the Minix NEO U9-H
      commit: 15c4dd131ce576f0150fadf7a3264c865b051eba
[2/2] arm64: dts: meson: add initial device-tree for Minix NEO U9-H
      commit: 0e9fed92c67cb886b3308df4890126d75db2ad67

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
