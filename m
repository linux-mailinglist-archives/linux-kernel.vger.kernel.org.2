Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F4D4448F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 20:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhKCTb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 15:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbhKCTb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 15:31:28 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF97C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 12:28:51 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id s7-20020a056830148700b0055ad72acb7eso3975305otq.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 12:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=b61kaA94Ee793GgceiiJmFJ4ShV9j6HR9f24wxuKQ8c=;
        b=T98f3VrIfGiesq2Z1XXhRSZk+N5YbD0SjQoDgIl2tEDteNdxswYV4QUq2MbYnmRZ9k
         7YcTBrJmq+u9Ba+a4S5548arcbTY4degLBnjzPd9VYyOyQ3Jlno/j9RGEY86eQeGpEre
         DbT2/CHOoLo3SuanWAMa6q22t3asL8yjCPYYTlnvBNxZGXxDYenueMaaejA07O3899bz
         eUidH78r2BLE0g4rfoe+yJi4NJgAPCjPiJ8a+7I5mhB5hjEm2UVu5Bq1iG38Q1p7TtMP
         1E9Zps9r38ryBNwD/RKD53QA9mft1fL5AvvIWAt6BxgN/XrALQMvL1mbhhMR/jLhJMDx
         l1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=b61kaA94Ee793GgceiiJmFJ4ShV9j6HR9f24wxuKQ8c=;
        b=IkMZhCO1LcW8N+HW2XLxG3jsXg0y7YwXGcNCEW+iPgrN0n20OQI0XOOj+LJ+7EJS8Z
         naYy+3JpSr3diVhVIEnvaqVE9t7D8Qa+LDs410RtUreO31oNSgUbMS+YfswmOdG4YNOX
         D69RKjBTw1B3SxAE0QNydPk/9A5ZAySf4X0hctU/HxZ7zRm96COMBYEwAxDanTrQBk6f
         lt6t59t9yBw5WY85S7eGGzqjieWsJNhkCEyl83kX862hPYQvMhG2KQ4wKc/Im/cb2PkH
         KMtlfrsOeYswfVuX5VYOuvwhJMIPRNH+o/ltIKiDnDC9ygHtesXPOw40AAUL/yj+vPot
         lWwQ==
X-Gm-Message-State: AOAM531HSgopSp1c6jLJ4hktw6VAeWTGZ9PVrX8CgaJEnn84TqaB5gbL
        UvvoWb2B9CP0XtC8r0mCt1O8Iw==
X-Google-Smtp-Source: ABdhPJxZNmzRvn9TAIPx2ko+UUajJ66iK1LzIcOX29RXqkWWpefaCi9UB3fGBgrRj8OKhlVi+qwvAA==
X-Received: by 2002:a05:6830:1d63:: with SMTP id l3mr2584587oti.9.1635967730638;
        Wed, 03 Nov 2021 12:28:50 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t22sm814853otd.25.2021.11.03.12.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 12:28:50 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Luis Chamberlain <mcgrof@kernel.org>, hare@suse.de,
        hch@infradead.org
Cc:     linux-block@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211103164023.1384821-1-mcgrof@kernel.org>
References: <20211103164023.1384821-1-mcgrof@kernel.org>
Subject: Re: [PATCH] block: fix device_add_disk() kobject_create_and_add() error handling
Message-Id: <163596772995.186346.6961527014377680159.b4-ty@kernel.dk>
Date:   Wed, 03 Nov 2021 13:28:49 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Nov 2021 09:40:23 -0700, Luis Chamberlain wrote:
> Commit 83cbce957446 ("block: add error handling for device_add_disk /
> add_disk") added error handling to device_add_disk(), however the goto
> label for the kobject_create_and_add() failure did not set the return
> value correctly, and so we can end up in a situation where
> kobject_create_and_add() fails but we report success.
> 
> 
> [...]

Applied, thanks!

[1/1] block: fix device_add_disk() kobject_create_and_add() error handling
      commit: 3554ce121f632db1f56f4e28dfe37da846617c9c

Best regards,
-- 
Jens Axboe


