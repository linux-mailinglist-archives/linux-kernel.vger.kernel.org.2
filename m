Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112E73FF549
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 23:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346382AbhIBVGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 17:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbhIBVGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 17:06:14 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DDDC061575;
        Thu,  2 Sep 2021 14:05:16 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ot2-20020a17090b3b4200b0019127f8ed87so1972180pjb.1;
        Thu, 02 Sep 2021 14:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VPHIe7iW67M00knOOa5aWM7V5Vqfw2TfAF3EkvnvdMo=;
        b=D5GF55cS7CANeiG4HMGiJYEZe6VtpJmNJUF9RVd38BE8mPMkPK4EDI+g7BmzNvYiCA
         XZscBU6O4sTSJoObwoHBWvBKzOJZ0s4lzh6mPTDIoUURmK+2KnRl/Y0rrUzRVlbbQIwr
         bPCIyryxYc3gOT94m3MXbnFxvYCHIFHcgnWCfls47rsKBbOL79U7tb42E6hJK3/c0RIU
         aoRmg5Yh0hUbx3A0KllwO029/xfl+PSWGcRM0Bg6JSeSc/0eXcZoRZJzLgWUJZofn9q3
         787xR2Wc1XlQSnUSQbIsScMrHWODUat9GoWbyRzuene1I4AqzmwoqfyJ9pt+FBCo3+1k
         I7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VPHIe7iW67M00knOOa5aWM7V5Vqfw2TfAF3EkvnvdMo=;
        b=QNLT4zhve3p8KGp2q9ByfpCAMzWWKnoJv9APmHVGnus5IxoP3BwCk6Sbt9BXlfO9U0
         SbLSZdV/WdohlQf9b3R309ecF770lapaudLy3YyEaNy87RrrkKQJWUFi/ItoCiBtakgL
         bYiWpiUDaz0onqFJZLfZtYCEuvJR8q0WytJfb/ENmF8jYzd694TrdnVMbmFHTGz0J/QM
         TAzPBkTnMNdMb4bYncmOhoa0ZcRUzV0ah4BYrnfZ0XxSZlwGZu2iLt9mNDdGnPbrgWQl
         Q06o5iCbmJ278Qh3B4bIhsUa4xzB40tn85eGvHknMF/ah9d0EG50imQ88pefJz/FQm31
         3lwQ==
X-Gm-Message-State: AOAM533FSlnAxz+1W7cnrUYeu932JXEj7FWi/UK1UkyAG1Pq//ECl4Jb
        HE/wEHZx38ME7vppv34zpPs=
X-Google-Smtp-Source: ABdhPJy5kDzrj+9AEkjT9UgJOU+apPh8sneh3GkTrr9jftjnK42sLUDonDINPV/vBqEegToaZJHKPw==
X-Received: by 2002:a17:90a:7c42:: with SMTP id e2mr5935861pjl.132.1630616715756;
        Thu, 02 Sep 2021 14:05:15 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n13sm3041814pff.164.2021.09.02.14.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 14:05:15 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Matthew Hagan <mnhagan88@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] ARM: dts: NSP: Fix mpcore, mmc node names
Date:   Thu,  2 Sep 2021 14:05:13 -0700
Message-Id: <20210902210513.3102856-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210829223752.2748091-2-mnhagan88@gmail.com>
References: <20210829223752.2748091-1-mnhagan88@gmail.com> <20210829223752.2748091-2-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2021 22:37:48 +0000, Matthew Hagan <mnhagan88@gmail.com> wrote:
> Running dtbs_check yielded the issues with bcm-nsp.dtsi.
> 
> Firstly this patch fixes the following message by appending "-bus" to
> the mpcore node name:
> mpcore@19000000: $nodename:0: 'mpcore@19000000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
> 
> Secondly mmc node name. The label name can remain as is.
> sdhci@21000: $nodename:0: 'sdhci@21000' does not match '^mmc(@.*)?$'
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
