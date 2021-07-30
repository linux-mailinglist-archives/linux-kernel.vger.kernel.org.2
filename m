Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7743DB5CE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 11:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhG3JWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 05:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhG3JWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 05:22:18 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F27DC061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:22:14 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id cf5so671106edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/yZoRBkftFgh9sXLWCqSA0NNYyaCCzLCtVVu+qXCde8=;
        b=Cnze41uObV3UjuyKBRXynffruXTghJme4w6xH2+CKNaIh5jdAjagHEtVi6brOprdI1
         hB7CgQP5ZMZ/wpvfAjvC7o0PiTQFG1Sz49unqZPzACDr4Fm9eaP7el6nWO74/isfRLPO
         yAdvxa/7NSLZglcZKCaV8LvCWyz+oj0SIaWafNT74kSpPOz13+bi933z+GlX+US69IUN
         C9lqUSNLFaNVuhLAnUUpRBw6yt8rNe4iRiWFtRIC8DWrkSQBN30UvEUMV1Gi4XpQHblE
         0bRkNR9LuW89ZCe0CmMVfph8tOr5sdtFopwv3F81Qv+h3F5TBv7M910U5VhGTZ+cIBbM
         +5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/yZoRBkftFgh9sXLWCqSA0NNYyaCCzLCtVVu+qXCde8=;
        b=gkZSlJOph2RK7uqD4oVkQep0IUbnDD3HRbbr1dxY+3CAOp+liHiq07OsK5WtLilxA4
         r0Zh86p7lrcTlm/WuecMyG8LtPq5QwC4ZJ1nm9x3TCWabCq+nhgqlD5KL1A2QxAf2m8a
         OdeMPEP75jrFSMD8dx+uOd9y24z697AwEY2J3OqH6AXB7OyWC5h0O5eqRPaeTmy2/Kyv
         kOzK4ptFDHy1iXohZ4DbwhTMy9ZM2VRTGTnK2oaG9NyLP8Z2coPO91jqz4zYUiqYcFLQ
         VxI1K4+5rnIODdwCz+IxKXanN7SBDniXwlJfJoCQtb+rdJTuB1GjzmxC5eNXmIVzhfei
         UH0g==
X-Gm-Message-State: AOAM532+Cz9L5Fljw60T5lGllk57uWj9TPEx97HRTn5mZ6IY0DcNPl4t
        AI3gld9FMr9rXFXu1be6ssxlMg==
X-Google-Smtp-Source: ABdhPJy4oM5AApIX3U2FLlWjmaeuzBFrALH3XEYx9p1j+sbBrABIeZKEW0bwiWMsceNydTvxKBGPwg==
X-Received: by 2002:a05:6402:42ce:: with SMTP id i14mr1833230edc.345.1627636932973;
        Fri, 30 Jul 2021 02:22:12 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id mh10sm357790ejb.32.2021.07.30.02.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 02:22:12 -0700 (PDT)
Date:   Fri, 30 Jul 2021 11:21:52 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 12/24] iommu/dma: Unexport IOVA cookie management
Message-ID: <YQPEsKymGXDnXrcL@myrica>
References: <cover.1627468308.git.robin.murphy@arm.com>
 <697a7c5da18c58e61e6b9a98b97775a2934a6358.1627468309.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <697a7c5da18c58e61e6b9a98b97775a2934a6358.1627468309.git.robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 04:58:33PM +0100, Robin Murphy wrote:
> IOVA cookies are now got and put by core code, so we no longer need to
> export these to modular drivers. The export for getting MSI cookies
> stays, since VFIO can still be a module, but it was already relying on
> someone else putting them, so that aspect is unaffected.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

