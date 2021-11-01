Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA48441A4B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 11:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhKALCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 07:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhKALCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 07:02:16 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2441C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 03:59:42 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id j9so8718056pgh.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 03:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Du3RdDKeh8d/WwM1bhUDKYYDQzg7en92iJDHOWcBOyo=;
        b=ZOPdrP9trG9iG2RXxn/odr2iVHSdmsIZMm6sKg2WEzvoH9qJpVF5Lo6TJEW/+RTrCH
         0t4gzaB5v0+6vuXoTm6U4nMq2w8By79rxMJUfcB3gg6GZ+YkEokPM0EeNi58s4Bgb/Tm
         UNQ4pVa43n0SR2iQcD5CcLwGHUasv2mizrAvHra1IfHABknLYmE2ZTffOjKo6cPQEZ6L
         i6lHcjNi+EdRQAT/NnfrId5t91DTDOwBUN0Br2/rrJgbAbTbnVZTerpzNniw8eyi1rN8
         sSjjh6/XsWYuDDVXfh1WZuSGDxCCCyAtFo+XR4izv5NEVA+1pEMsuPSaZDmgPXonFWGP
         jM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Du3RdDKeh8d/WwM1bhUDKYYDQzg7en92iJDHOWcBOyo=;
        b=i0z4VckrpWCYq2Rn4yNq/I2vEEN3aGKIC/u+zt4Wk3GVhAqV7aNON6h/ng9GfvTgXM
         3V8qPt3HT6LzIPRvq0ziYxHPP1mhv/JEXKtyP7c6I6KIy8q5NF5Z2ZZpPofNSrZYWn1z
         MKkQeQhFKVtc3nE6aFNd2OfifNtELE2bhepccaCeDTOzei/LattqPNI8WK9ALp2A1sJY
         75Cp/6B3ZzbAsg8nUseC1hIwmloSwyQ/iMuS3/qh3heqsO8ftVHP1WhkmdeITROJfLcu
         NoX26GhvTRhSPdnRjMEnyjOKHuthGmDoP5fzuPucN4NmUenymARF3XUB2IIkpvfY99UE
         65gg==
X-Gm-Message-State: AOAM532kevsSOrH2CUzoN7VFAJactTMkRAugsBv17yX55BWrzzU205eh
        eLKtKO/Cb2LRxd0Qa4jwjhzS+Q==
X-Google-Smtp-Source: ABdhPJyjqamA36C/F4jzZl5mgFp20XtycHRu1lZlE+OPkr7oKWZ8pR/b6abnMjLy4KU+zz9qy+pv8w==
X-Received: by 2002:a63:6f4c:: with SMTP id k73mr21295263pgc.61.1635764382391;
        Mon, 01 Nov 2021 03:59:42 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([103.136.124.227])
        by smtp.gmail.com with ESMTPSA id h18sm16015568pfh.144.2021.11.01.03.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 03:59:41 -0700 (PDT)
Date:   Mon, 1 Nov 2021 18:59:36 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] coresight: etm4x: Add lock for reading virtual
 context ID comparator
Message-ID: <20211101105936.GA352474@leoy-ThinkPad-X240s>
References: <20211031144214.237879-1-leo.yan@linaro.org>
 <20211031144214.237879-2-leo.yan@linaro.org>
 <df07c7b0-0145-8290-b4cd-a1831f19330d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df07c7b0-0145-8290-b4cd-a1831f19330d@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Mon, Nov 01, 2021 at 09:49:06AM +0000, Suzuki Kuruppassery Poulose wrote:
> Hi Leo
> 
> On 31/10/2021 14:42, Leo Yan wrote:
> > When read the virtual context ID comparator value via sysfs node, the
> > driver firstly reads out the index, then reads the comparator value
> > based on index. >
> > This patch adds the spinlock to protect the atomicity for up two steps.
> 
> minor nit: This could be :
> 
> "Updates to the values and the index are protected via the
> spinlock. Ensure we use the same lock to read the value
> safely"

Yeah, this is more simple and clear.  Will use it.

> With that:
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks for review.

Leo
