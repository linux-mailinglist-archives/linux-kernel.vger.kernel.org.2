Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81ED93062FE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 19:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344343AbhA0SFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 13:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344148AbhA0SFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 13:05:22 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3895C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 10:04:41 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id o7so2134584pgl.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 10:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QwsWwt6yAHjK9HfVabcgNu82UtKfBUdWpM4ef78ZV3I=;
        b=wiO+ivWvSpUYWfyfpPlSXStix3+/FQAsTydsfiZm3SbqcNtYhazTuwG5Qt2a492wJn
         yDIk5PUDdqhOe7D2C9EPIyhnH9B2WdZ5X5jDnNRul99E4zf7xq9YDFn5gF1xoY+IzlE7
         OVoKFu64Y0XHXZelv7Hr/N6S91NBZwIgh0reZEE4/TmwgAJhEbXkqj3tWBVPkA2Kq/5G
         //MkxqAoUtFRzPZO8cKe3/eeq3FaJhWNZN5aV07rLbtQsD1jD9EBqkm8BwfcWnI2EeM3
         JM4HYC5+MkuBsBxxR9y8dl+UabTVtH5zP8SZTLdjUrlYrNJyPju2trfXyCB2RQM0U4gR
         /36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QwsWwt6yAHjK9HfVabcgNu82UtKfBUdWpM4ef78ZV3I=;
        b=jqOEcYZMlfzDCfrEZ21nf93kOLv3XpV3M4GLNZZJCTPVGSO/oY8NxBkDd8Mk46PKy1
         +Y+Tx68g25Ef0fRXNA3JnfnAQl0AcqKkQix189SeonG1RmcmV2bLePJeL8h+2FquNCgq
         CL3+LpuultibrZmAG+sDaUIngT+Zj5QJtttAXBF1kKF7Q6bdLLIGOWlm2DlRfa8TSl8l
         yEtHSlhwtFmbsB/7zyRotIg14QoqonQwQgdqsvGQjWzy7H2LkfiCFxY9yfVvOuAS5Hgs
         zDsRCRhP5ja52uNqwPYhORX3cGd5FmX5fwPaFUB4666sIKAGdRxJek7+HzA7v9+OdN+q
         M7JQ==
X-Gm-Message-State: AOAM533tY2ojlmcFtPx3KK4RJk6mn2LA2Yy3qexKazgKnzepapLzfruP
        xhgYVOsVwXoOWBQLVKDe0kISvDaKFrH6We4GubU=
X-Google-Smtp-Source: ABdhPJzbBLxWLKPHKRPU1ciU8xZx1TLCFPLX6mwn7aVtDJ0xSlZbVVNDhmsBQJzTfKE+z3t0A+lrJA==
X-Received: by 2002:a62:aa03:0:b029:1b9:7cb5:bbde with SMTP id e3-20020a62aa030000b02901b97cb5bbdemr11756431pff.14.1611770681170;
        Wed, 27 Jan 2021 10:04:41 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id kr9sm2693998pjb.0.2021.01.27.10.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 10:04:40 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Brunet?= <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "arm64: dts: amlogic: add missing ethernet reset ID"
Date:   Wed, 27 Jan 2021 10:04:40 -0800
Message-Id: <161177067430.24026.4667361379559642494.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126080951.2383740-1-narmstrong@baylibre.com>
References: <20210126080951.2383740-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021 09:09:51 +0100, Neil Armstrong wrote:
> It has been reported on IRC and in KernelCI boot tests, this change breaks
> internal PHY support on the Amlogic G12A/SM1 Based boards.
> 
> We suspect the added signal to reset more than the Ethernet MAC but also
> the MDIO/(RG)MII mux used to redirect the MAC signals to the internal PHY.
> 
> This reverts commit f3362f0c18174a1f334a419ab7d567a36bd1b3f3 while we find
> and acceptable solution to cleanly reset the Ethernet MAC.

Applied, thanks!

[1/1] Revert "arm64: dts: amlogic: add missing ethernet reset ID"
      commit: 19f6fe976a61f9afc289b062b7ef67f99b72e7b9

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
