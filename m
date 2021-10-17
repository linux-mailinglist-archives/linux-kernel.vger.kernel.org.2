Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEA0430938
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 15:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242316AbhJQNF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 09:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236484AbhJQNFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 09:05:21 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83D6C061768
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 06:03:11 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id b188so8247163iof.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 06:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cpHZ7r0xJhtTVNnwnC2/v/oL0NL2Mq8QcDvO2xernog=;
        b=CmNJkyumqn2veFHFq4gljV+Uvx4uvgW0UcP7OCqp1IeC8MXGY+7pE/ld5GE4VhnY6e
         kNOKTY+rOpzpSqaa73j0pmtb2hBD5MXsEZH0C1eBtwBXHc4hFNd9keW30ePIV/BCEZrk
         qEPl1k3RJNgPCA2aK4WE1H2la4/MeIrPRJlNZjTCGEMlZ/I1MenhZZXpkwBDMeslScFG
         aGSCq5exWY0M9b7RPsQO7mqP9RXbIhVkVp2cfMiUTeaTIHFimvXfIb0pmxR5OASyuy7i
         m/B6WzIIQgbD2v6y6Kq6IORz8RPzERNOxiNu+vKQKrPyfEmVsR5CQ/N5JrXmp8KHasDX
         FH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cpHZ7r0xJhtTVNnwnC2/v/oL0NL2Mq8QcDvO2xernog=;
        b=s6A+Y4AJIOl8WUB8J9BrJluGeQC+Fg+V70tHM8pYoY1WrRiEKithx8TjlNur8TOTru
         pdu2q5nQlDtceLlIesyYZ+OOQPuNVN9qc5B2c734rmfupm/ufwGwbAz39wWy5JmRQTZw
         Kb6/0iq6Z/INBknv/No5zC882Riu+hZZJ38hi0mMKCDIFy7g6akggQ+3PUZU0cQ8iuBc
         n764T+oPd8/SDDpSFwquObHZ3h9NPccZd7x68eZvYDND8XwKqirrTtcXiPEzufRVLQR3
         qJ/POyWgeMLtu5FAEPYMXAxxdTSq1cE68pTttSWdK52LX0+EqH7cBWL9Pw/x7KxbXKXq
         DcXQ==
X-Gm-Message-State: AOAM531JwxBtK8M1ExED+uUAaY68Lt514+3QMfIeXZ1WrwxTn6UTnB69
        y6hL76UKwpv37aeqiQ96+jFqg95zPRKT6Q==
X-Google-Smtp-Source: ABdhPJx4iSggqclLbZlTWfHwCsa83vp6P8YD2Msi27jk+2CYfGoHuU7w0epdKWXm5Z6GR/3tPsZYeQ==
X-Received: by 2002:a6b:f816:: with SMTP id o22mr11299221ioh.106.1634475791291;
        Sun, 17 Oct 2021 06:03:11 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id r11sm5585992ilt.83.2021.10.17.06.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 06:03:10 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH BUGFIX 0/1] block, bfq: fix bug 214503
Date:   Sun, 17 Oct 2021 07:03:08 -0600
Message-Id: <163447578602.89992.1872535198744308847.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211015144336.45894-1-paolo.valente@linaro.org>
References: <20211015144336.45894-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 16:43:35 +0200, Paolo Valente wrote:
> this patch fixes bug 214503 [1]. Commit 2d52c58b9c9b ("block, bfq:
> honor already-setup queue merges") has not to do with this bug, and
> can be restored.
> 
> Thanks,
> Paolo
> 
> [...]

Applied, thanks!

[1/1] block, bfq: reset last_bfqq_created on group change
      commit: d29bd41428cfff9b582c248db14a47e2be8457a8

Best regards,
-- 
Jens Axboe


