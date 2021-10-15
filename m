Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DC742FA19
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242342AbhJORZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242341AbhJORZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:25:00 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33786C061780
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:22:24 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id t4so14016868oie.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rzyEN2IKemEthFw0BhV4JmnKiL6LJx2wO9/bgd19Ox4=;
        b=M493+FP1Xy2KglJSyE0b3mrxkEeDorK3QcDt8nbhgmASBjTYSH4ElUGss0AaxmLdMq
         aSKRC1MxYuiOngTyM0o5zjs2fo2XVFAZOiAWWDwv3q+7niV1iOiuN+09r2k8gT0PMPHc
         kHieRShGPo6MA1/AFtYVnU++oaorAI6NIM2g4vgO8rXi4eRGZai8dCQUc9qTmGoWwni9
         AVOYtv1HR/iRoJ8U7aBmfidQA9VrCZzK7ANKrXdUmkmR8ZGMELU24+TuevtMOIJ5U9hF
         /JmSeOAYjgiX/OdNaqVNbnAYZxqRouj1kqYtcGYG9rdKdds88ya69iuNg5VFh3jCxHaA
         Dggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rzyEN2IKemEthFw0BhV4JmnKiL6LJx2wO9/bgd19Ox4=;
        b=HBThnVcSZnAqQ//txGg0IgDPV4LlWLr8PSRQlleRAqU7LPKFPD2xzJOPm+FZT+78FY
         RrHxFCwwIHxRvyZdv3ijKC896bR0toAPZTCBBn4ih0+Kdb5NOmv20CI/lwOa31bMWndo
         FiuJdCDU0Imt0+Q7JqX/fH92eXh+bygygMgBsFTsF8tHsWx5giBEdtzLwzLuuBWkQQv4
         b4/EVfpX+acTkqae1hkq4WJdPbnIkCvdS1vsfLjHAEC3W4XKnBbtf7VgOvzl+dI0A3AO
         KZl7aiKSrqDay2GMIukq92C41r5X8U3zKFnCj1UJrUuM3V2VZ+ihl+PbR8nYGg7vjJ2y
         SNbQ==
X-Gm-Message-State: AOAM533RtXyEMhKkaRYl2dXCF5SWiPPyYkSwqLqsppnyqn+QJRCgN34Q
        En7gLoO34WErRQs2qB5TZ/U6gQ==
X-Google-Smtp-Source: ABdhPJz1rE34/rvD821RRnUmK8MzG4eBOu/mcVUiajrQWknwaD7hxsRnR2OCOahn7vdL+bbnp6zaZw==
X-Received: by 2002:aca:bd02:: with SMTP id n2mr18572809oif.113.1634318543564;
        Fri, 15 Oct 2021 10:22:23 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id s206sm1289635oia.33.2021.10.15.10.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 10:22:23 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     mathieu.poirier@linaro.org, james.quinlan@broadcom.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        ohad@wizery.com
Cc:     kernel-janitors@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] remoteproc: Fix a memory leak in an error handling path in 'rproc_handle_vdev()'
Date:   Fri, 15 Oct 2021 12:22:13 -0500
Message-Id: <163431847249.251657.11309404044031278395.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <e6d0dad6620da4fdf847faa903f79b735d35f262.1630755377.git.christophe.jaillet@wanadoo.fr>
References: <e6d0dad6620da4fdf847faa903f79b735d35f262.1630755377.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Sep 2021 13:37:32 +0200, Christophe JAILLET wrote:
> If 'copy_dma_range_map() fails, the memory allocated for 'rvdev' will leak.
> Move the 'copy_dma_range_map()' call after the device registration so
> that 'rproc_rvdev_release()' can be called to free some resources.
> 
> Also, branch to the error handling path if 'copy_dma_range_map()' instead
> of a direct return to avoid some other leaks.
> 
> [...]

Applied, thanks!

[1/1] remoteproc: Fix a memory leak in an error handling path in 'rproc_handle_vdev()'
      commit: 0374a4ea7269645c46c3eb288526ea072fa19e79

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
