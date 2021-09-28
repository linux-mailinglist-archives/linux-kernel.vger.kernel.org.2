Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CAD41AD15
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240236AbhI1Khj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:37:39 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:58016
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240200AbhI1Khg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:37:36 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0CF17402FC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632825354;
        bh=AJzuKk/vJuyADYn3Tyc95ocSPqoexwLNcmXZAoYOW8U=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=pYxAL6OxyyDYnqsuk0lRFtxf0xisR0kINSyDlbcH2TQ4nO+ALjKCFX7LfnE0ZmTxH
         1FWdiVd3v8UgX7Ow8tLZ4Z4RgiEg/ac7Zqs9fNJiJ/HPsp/R/P+nYRB/DeRCju3/sl
         phsUIusVVN0sIdemuHAD958jphmYLByjXmXp82JTMQK9L7phNLPSUOWUb2b18scSrN
         CpzcmbUJS5hrEOByxiaAqUZhFtUZRw4jKl8ndloyYcLc+DTercv/EV+9/WqFUveUY0
         YO5BZC7qZOpM5+3SAR3mVFPiY+mlhIKdiTcvLDygaMsWMDkhHHxW+lhAAx7c72ww7u
         czxh5sPIEtyDg==
Received: by mail-lf1-f71.google.com with SMTP id r14-20020ac25c0e000000b003fc149ed50eso18913668lfp.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 03:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJzuKk/vJuyADYn3Tyc95ocSPqoexwLNcmXZAoYOW8U=;
        b=IOsW6Ek0V1Nfe2TU2gqAI+oDGx7dLJfPctGwBbN3BXW4Ku9+3HA84Lz/u0dlPF8rjt
         5ndXgDXYtd9KoMwjUw/7iJOF6CSmVe9kQUA0YAYSkE424O3XuwVorl5lAGUhOGQxxA97
         FtbM/5k93Q7TIWsoOSeAgys80+5b+MjCdX1aAOGHbYbQT1afjXlt4M4qvHRdmLNwdJmO
         GiUGU6m7hJEhvgbDtU/kgcVLxHUW8VjqBVEobOr9NFqc8dyvlP2t159+yD9+7NDWM4Uh
         v4Q1WalxzQ9FwlP8clmz0rfzivrl5b3syNL1e40jsQtsZdT3wBrfQH89xfuE1BIREmWM
         /mtw==
X-Gm-Message-State: AOAM531pS2qD8ckdSbUpuehncnW19ZtgagPgRCw8sKm0SqMTlQySDB5e
        H0+//fNLKtxp1+88Z88QCvyaSnwmbzG6Cz/xls+5JUC4rl40TJTJPz3GJgiuBCY+XRHSVmihNsC
        tOyjWSZgQ4kcYDWh1N0t2j4b8JjTb3mQrb82Fupl5SQ==
X-Received: by 2002:a2e:4802:: with SMTP id v2mr5077368lja.501.1632825352591;
        Tue, 28 Sep 2021 03:35:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNA8WgVR2+8ER4/6MC54ucH82pwm2S/NMyaoL7vkvgrzQsMxv0gV4MfGvqmFBtf4FYGPJbbA==
X-Received: by 2002:a2e:4802:: with SMTP id v2mr5077357lja.501.1632825352420;
        Tue, 28 Sep 2021 03:35:52 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id l6sm1809230lfp.143.2021.09.28.03.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 03:35:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-renesas-soc@vger.kernel.org,
        Duc Nguyen <duc.nguyen.ub@renesas.com>
Subject: Re: [RFC PATCH] memory: renesas-rpc-if: Correct QSPI data transfer in Manual mode
Date:   Tue, 28 Sep 2021 12:35:48 +0200
Message-Id: <163282533892.34438.1878675609177525004.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210922091007.5516-1-wsa+renesas@sang-engineering.com>
References: <20210922091007.5516-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2021 11:10:06 +0200, Wolfram Sang wrote:
> This patch fixes 2 problems:
> [1] The output warning logs and data loss when performing
> mount/umount then remount the device with jffs2 format.
> [2] The access width of SMWDR[0:1]/SMRDR[0:1] register is wrong.
> 
> This is the sample warning logs when performing mount/umount then
> remount the device with jffs2 format:
> jffs2: jffs2_scan_inode_node(): CRC failed on node at 0x031c51d4:
> Read 0x00034e00, calculated 0xadb272a7
> 
> [...]

Applied, thanks!

[1/1] memory: renesas-rpc-if: Correct QSPI data transfer in Manual mode
      commit: fff53a551db50f5edecaa0b29a64056ab8d2bbca

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
