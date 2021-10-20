Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986DF434CFB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 16:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhJTOFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 10:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhJTOFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 10:05:05 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA29C061746
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 07:02:50 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id l24-20020a9d1c98000000b00552a5c6b23cso8322805ota.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 07:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lDqH2jUk9gpO3lmRRDRBqbmD26jEPR69skrcQuuIqmk=;
        b=t2djaRphM71qBUm91JfwhfeYSz+3Q+ablSn5dDN5v4PisUMlzowKx0xHYIYaWd2fRi
         XNDXRDcH+Rg1KFeM1hcMS24utEtk0+gdUrt62iSzFIYbLuq/vEUb/GSUSFU5XAFafNng
         ItcQxBMuY52cXB5k/7E/lNq6oT12vL2K/zNas791ZSzNzRA4dde0KYRHOiL19uyFze+Y
         8KKJS9gt9up1i8tRZK7Ow+QM29FGmY5sz8skdm/+OpI3q0xLNtKkRG9WLmVFxSCrOt6v
         QUynbYMrkUOEurm7BQ3D5obyEOuVTeLVfXjRBQNv/0A12X37qKgXSNCBb3qNPPwLmGOF
         1MCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lDqH2jUk9gpO3lmRRDRBqbmD26jEPR69skrcQuuIqmk=;
        b=UPSZAYShklk2V+YU1zb2qPP42IWzAQFivLj2uS/JxRUOrw7aJ6I9pswcz0/AGnGRms
         je8YuxxnfS/BLVE7ccU1F1VFHC8L6fEcTDg1TSDlfRpX+5xA9cMUoqUJoT+2qzanw8fK
         09YFeiuiVUYR88wL5juQa5gi58NVEg2z8GU9C/fEGIxdbuJSzpTIeyf4HL9b5rRs2Mjc
         FZoh/kNn8oLt0yXjcnBEIg/XqBJyg0kMCfqtX+MZuFCGbxMkBlzoJ0hhZ51GSv+4Y6CO
         bIH5j2VaNB/8mHntLI4+qNMto87o3BDRy4Jwn3inn0xG4VzIPCF9VvKTuoDXRwFyRG0n
         h5Gg==
X-Gm-Message-State: AOAM532U1SeWCE5bzc4a2L5hU42rnm3xgHvLgCjB2n6t+hSvj67O9EAM
        RajBbRNP9zIUUTz9Fi+jBo5ALw==
X-Google-Smtp-Source: ABdhPJx4cWu2P//XiYfbWLSIEMz8tbikXeNb2PRTVrKyCMlvUVQ4KtZk/remA8V88hHEJC+fQaTHrA==
X-Received: by 2002:a05:6830:308c:: with SMTP id f12mr32432ots.15.1634738570136;
        Wed, 20 Oct 2021 07:02:50 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e22sm489662otp.0.2021.10.20.07.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 07:02:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     cgel.zte@gmail.com
Cc:     Jens Axboe <axboe@kernel.dk>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        io-uring@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>,
        asml.silence@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] io_uring: Use ERR_CAST() instead of ERR_PTR(PTR_ERR())
Date:   Wed, 20 Oct 2021 08:02:46 -0600
Message-Id: <163473856398.730876.13037999645192762534.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211020084948.1038420-1-deng.changcheng@zte.com.cn>
References: <20211020084948.1038420-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 08:49:48 +0000, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Use ERR_CAST() instead of ERR_PTR(PTR_ERR()).
> This makes it more readable and also fix this warning detected by
> err_cast.cocci:
> ./fs/io_uring.c: WARNING: 3208: 11-18: ERR_CAST can be used with buf
> 
> [...]

Applied, thanks!

[1/1] io_uring: Use ERR_CAST() instead of ERR_PTR(PTR_ERR())
      commit: 898df2447b9ee8d759e85d33087505d3905bf2f0

Best regards,
-- 
Jens Axboe


