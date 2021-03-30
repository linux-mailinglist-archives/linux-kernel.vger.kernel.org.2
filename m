Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44C234E01A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 06:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhC3E0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 00:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhC3E0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 00:26:53 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E34C061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 21:26:53 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so8783659pjc.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 21:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platinasystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=amQkhd8fLGZRPPJUB14300VNr0MzcVU8fRDKRIiZlqg=;
        b=ucGgrCSgKN4NQH3jj2HTuP7UG01/lAvGmcGLx2ufrA06x5fHrsLN8WK+++ueE03Kax
         JGoBAlFtoeFKp8ptjRKoJYzDJ83BMNee/IXlXVUZPNx66tMZtQjWIVFhoFrolOeHz4Vz
         K/GyFxLNMuDARJ2KBcKzSuIJ9p/JjDuWsHJcnqOrR/AfjSONs0ZQ4tyCc22KiuAt/Hvn
         15B0vQtpMd7dQ1wQldrxs28Vp/+0U4Zm0oVSlLBuUr9eSddhBUgNqBlriscG0IqNd+L/
         y/FlL3q3VLXjbNaDyVAerAxraF1PpOi9YYoGogVzdT59YrkvqD2uPHEYKKQWzhscDl6U
         Si8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=amQkhd8fLGZRPPJUB14300VNr0MzcVU8fRDKRIiZlqg=;
        b=d9+dtNj3c2NFDN2coMhv0j7BlD15lYb/JNCe95vIfbk0YtpSzICJzs3bLAgsEp8BCe
         leSAOP18TuG2I6PZoG+8dnpIhzndFQ3DAJqYXQ7FUx82dn9oz0VJlf+Etk+IVhXZrJOi
         ey/MnQWbI6hH38DNoo4+YfeouMDhDtg99xWtvj+7emTaTEpVZ3HRuuNydkQmSCL19Bz+
         2d/O2oQqX/6FguNtMXDejptM2naXq0ztdx5TECJjzmvGge4A6EfdMz6jR3xK8trwqBq6
         q3E8W/opf0pdOUwrj6P+FJrdsxaZksKxG+BLNKCZkuY+9U7B8M18vHNw4uV9RiBJlRGk
         SXqQ==
X-Gm-Message-State: AOAM5306UDBAIpTzZExirowbD2lYQIaiPfwS1RdmuCov4GONlEXW3CMJ
        kU4Gu8BmiAOyQb74OYPd/Ok6dw==
X-Google-Smtp-Source: ABdhPJw6H1zvqQLUhtLSXn5oyGF04JK5wkHdAbb80IUmCZYpHnTABgYPMnislkAmdg3wNSjs+71XZg==
X-Received: by 2002:a17:90a:8981:: with SMTP id v1mr2511490pjn.230.1617078412686;
        Mon, 29 Mar 2021 21:26:52 -0700 (PDT)
Received: from localhost.localdomain ([207.53.255.56])
        by smtp.gmail.com with ESMTPSA id q95sm1245973pjq.20.2021.03.29.21.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 21:26:52 -0700 (PDT)
From:   Kevin Paul Herbert <kph@platinasystems.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Tom Grennan <tgrennan@platinasystems.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvmem: Change to unified property interface
Date:   Mon, 29 Mar 2021 21:26:31 -0700
Message-Id: <20210330042631.2945107-1-kph@platinasystems.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210329223827.2851916-1-kph@platinasystems.com>
References: <20210329223827.2851916-1-kph@platinasystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


THis first version of this patch erroneously had an unnecessary wrapper
for of_nvmem_device_get() even though the commentary properly stated
that the only wrapper needed was of_nvmem_cell_get(). Fix the code to
match the intent.

