Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D0A43052D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 00:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244696AbhJPWNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 18:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbhJPWM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 18:12:59 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF83C061766
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 15:10:51 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id j8so10948865ila.11
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 15:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i8NcHpSItiwZ9TaoEZMfLmWFidB9gDloE2VLdIjDcgs=;
        b=3Pm5KYOhuV9RT7njJYaaA9ndYPtEBlXxdLvlLSBLHLFDLK7ZEVomlmUvoFkKPp7Ep6
         QoM7EKB8KbB0eaU3w5L++u69Fp1Ls4jYQseN/yp+QRD/6R5ziGcpJ+uIvesyizDU2eNe
         0zEoEEt3ftSLQ73PzYkwO2fscmCzVhKuAEj6F3Jkdsry9XUy0n8MQxhg638tHA1rlZe8
         OJlyNaW8X+YjBuPBT5DhYjbuR3DhnGmPYIrY6Lpsw8V7vUiCZSq+wB+WcbER6QAgDITe
         ymSIankewQIbzw0Z34xqD3dfugRH+hNaZA/jgluT7m+E/sS3hXYxYIG5CGVFLZ4zPCra
         wPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i8NcHpSItiwZ9TaoEZMfLmWFidB9gDloE2VLdIjDcgs=;
        b=o7W0Nft7jHOAJQU+MDhuj3o8Lertl0kdEZxSydPPJBLW92r5qvR6HeimQB9kEqW60O
         pl4etYbSJipnBWtYuTPT28CWGYrckhXysJ72IbTnDl8hFdUKC4xBRskiHfYsHlcTk8Hb
         6+ALWnfrv7woIiG9mzABoVitfNv9H4CuUYLh7y2zj0SJcOLnrZ8XW1tj5RExFRxUXWaB
         VsVNXgjcqSuygMIfGP5XMneeud8TFAKjjeXJhK6TZSd/DXt4qVluZarkm7ph6wzXEOHN
         4i++TIHASWndH/TXpX/l3C2WHzWpHfyTtnFmQqwvuLQ09ACMtclLumh1wZ4xI2DzTtlN
         d1WQ==
X-Gm-Message-State: AOAM53266AJNjTqfBuWQZEM9u/b6afwmKMjIlvqoR+LCrzfM2EnXUB6i
        uPDmsgm6IUqWv+7LfTg8QA6TBw==
X-Google-Smtp-Source: ABdhPJzAGVkiuOkmT5LAu4eIj0//pVhofQbXmBHEFbUQ6bbkcde1SvxMEVDnMZwnRREhGlH3hBpFWQ==
X-Received: by 2002:a05:6e02:1c46:: with SMTP id d6mr8641201ilg.117.1634422250269;
        Sat, 16 Oct 2021 15:10:50 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id q205sm4640238ioq.41.2021.10.16.15.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 15:10:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 0/4] block: clean up Kconfig and Makefile
Date:   Sat, 16 Oct 2021 16:10:47 -0600
Message-Id: <163442224212.1141648.15209524413845277700.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20210927140000.866249-1-masahiroy@kernel.org>
References: <20210927140000.866249-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2021 22:59:56 +0900, Masahiro Yamada wrote:
> This is a resend of
> https://lore.kernel.org/linux-block/20210528184435.252924-1-masahiroy@kernel.org/#t
> 
> 
> 
> Masahiro Yamada (4):
>   block: remove redundant =y from BLK_CGROUP dependency
>   block: simplify Kconfig files
>   block: move menu "Partition type" to block/partitions/Kconfig
>   block: move CONFIG_BLOCK guard to top Makefile
> 
> [...]

Applied, thanks!

[1/4] block: remove redundant =y from BLK_CGROUP dependency
      commit: 21baefbb1558318bd32b3a5130dd93d76d64df72
[2/4] block: simplify Kconfig files
      commit: 59b0555ae1c3ddc506c64ad44efa1841ad5843d7
[3/4] block: move menu "Partition type" to block/partitions/Kconfig
      commit: 9b95c675b440156da5b99194e47755728362f4b6
[4/4] block: move CONFIG_BLOCK guard to top Makefile
      commit: 782b51ee1f9915942809dea14e7881489cf3ff10

Best regards,
-- 
Jens Axboe


