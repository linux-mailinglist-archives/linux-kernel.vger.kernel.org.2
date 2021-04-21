Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35878367368
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243447AbhDUTZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbhDUTZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:25:52 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D12BC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:25:19 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c3so11027903pfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ek4HM+AMfhrtBceEoaqKaZCGvxaJ9XRd6T4BFcnTSbg=;
        b=LqBXbljSGHnE4kZak2tnnIS9FLPoj5YYnIIkKoXXZ8L6bDR5MQqrkbJLcjz1ZnEvAl
         MYL5kWxYBOxZZurzhDrvniCM2EJrY35Gnc78+8dB+5BCS0fvZ61TjxaLMFI4kkmXzl9Q
         3PZk5I5c/PI8euiQztaG+ya5JF1vyO4UVv4Mj/bguZHAk2tGtsuYZVsj75rZ1a5iWjjv
         F9TxvK5F1WQtxTSayjozJpL4OL7i+m1t7cVPYCWvzAhBkxx3CelfYT3cJonqTu2V0vxx
         N5le2zqLA6UDtIJVYysmcj/QTkRnAkCqyYobxpwQwDaOXvytTDb3h15vQjcNNknocwvx
         pgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ek4HM+AMfhrtBceEoaqKaZCGvxaJ9XRd6T4BFcnTSbg=;
        b=VYT1IdHyeeIp1q6/SPerwBeKbxL6drWetfh6s/ZRrA+VsdYqkXpJTwdu5h/VBLeZlo
         /efJnBZ488e44mLclZcNULmwA7ALKizOjwhP+Nt64e8tJ68Uw582JWdg4tUMKiyyQuzE
         udq7/tcl6baEF8LJSCULMhvBuLChDYowV5YukOrLLA90jjJe/L+M34sgQKgKg5xNCLG0
         AV14l2oD66iOpx9YC2Bowiq01dQmKycJ+fkIIzmO/FbqWAxc8uORZssGRcMJvRIswyLR
         6fW5C8JgK9YjAVtPstbDI82gyc75CTmDKWSsvrU8eCfQo0RlcEk9hqGtsbdbL+6DzBZ0
         Z3jA==
X-Gm-Message-State: AOAM530RnDXTyLPICSOQSTkpY3iPIn28aC53/A4UoEX1wlo+BYK/c0RE
        2qCcalqWtmre+Vh/p9GhqFo=
X-Google-Smtp-Source: ABdhPJxOCD6BPDvonp3N2DT3AuPEvMKoYbQFrivw0T69pCgCei1fG7N7yzvtO0fr1sXIWSGEIQpU9w==
X-Received: by 2002:a17:90b:234c:: with SMTP id ms12mr7633941pjb.162.1619033118851;
        Wed, 21 Apr 2021 12:25:18 -0700 (PDT)
Received: from localhost ([2601:647:5e00:17f0:a47b:2362:7918:fbea])
        by smtp.gmail.com with ESMTPSA id o62sm101377pfg.79.2021.04.21.12.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 12:25:18 -0700 (PDT)
Sender: Roland Dreier <roland.dreier@gmail.com>
From:   Roland Dreier <roland@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     jgg@mellanox.com, linux-kernel@vger.kernel.org, wu000273@umn.edu
Subject: Re: [PATCH 044/190] Revert "RDMA/pvrdma: Fix missing pci disable in pvrdma_pci_probe()"
Date:   Wed, 21 Apr 2021 12:25:17 -0700
Message-Id: <20210421192517.1327240-1-roland@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210421130105.1226686-45-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-45-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a really weird one because the patch actually looks correct
and the revert looks wrong??

	ret = pci_enable_device(pdev);

[...dbg statements...]

	if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM) ||
	    !(pci_resource_flags(pdev, 1) & IORESOURCE_MEM)) {
		dev_err(&pdev->dev, "PCI BAR region not MMIO\n");
		ret = -ENOMEM;
		goto err_disable_pdev;
	}

 - R.
