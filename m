Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCF4362A0C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 23:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344165AbhDPVRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 17:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbhDPVRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 17:17:51 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70395C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 14:17:26 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso15278104pjh.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 14:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gqseJO9CGkz4pjTNjpt/nx0Gv1B/seEPYR8+YldK4DQ=;
        b=J+QPCrpx5ys3um23Pc3yHQNgbQBS4103CCl2Za2cJAFOtNUQmPpsfEQ74i71MpZBQC
         2bYZNMCARMNZx4TEkbh+Gj5F6SWwVPT/WHUl6u0TXoUh4VeK1IXyW4zVQDg5MoZgsMx4
         QBngws+jfRZ3sC63TPG+cOd6pcVqR0Xwcc9Fvc3cZruLBUpbtsN5XrIMkNAzXKR3IhHs
         dkPkQ35otebcIopwyk+vV+f5YmNYkDJ7dqYJnrgn+sBYC5CfBGnHzWsSVo1laofykT2G
         Q4N/UBuipQMC0Pzcxnl0zgyPYDXZyJEmryh+Yt5fb4MrcEjly7AGOpdfe30uAGvL4hm6
         6Q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gqseJO9CGkz4pjTNjpt/nx0Gv1B/seEPYR8+YldK4DQ=;
        b=rvO/QPJnZjgdEPIAheIFo5mltFeFVhZ6DifOZVDJ0Mw1sznmiH7wjrVzEEITFTqfST
         jzSP48wJ97Z1TxjpTkX3ruzXQOa4jQAUHq24f/mhb/XbJvzrQKXUw2N/Hap/2heno7cY
         U1M2L/vnHmoGdH5SAHKC6Kh8e7kliuw2dFof/jScmCaBpjICrsXrar+uKSu0y1uGDx8s
         XCayTiRL70vTNg4YcgAMZeC1LfO7IxNoavri4PyUd+3F78SxnJ6WMI1cdwtFCE/djlsH
         dUdKaeUpfGzd/h1HMBhJGP+6HbQ25QlZQTzj+Y4wl+z0BQ+N5MlnQ5zR5QHUP5cybPDp
         w4Mw==
X-Gm-Message-State: AOAM533S4m5s0chOYNHFS8qGooI29kbmOl6LqVgA34vzXHh5mIJ9NYP6
        4D5AZzjsuPldrxy7zgcTlwtfS3Z22rZTTA==
X-Google-Smtp-Source: ABdhPJycKk0fhXKxdfx45MkKO7GBaFwkMCNnqoM4DLdWSYUjMpfakDZWHaWqmCxWKbXspyPy9TVsow==
X-Received: by 2002:a17:90a:7e03:: with SMTP id i3mr11562361pjl.234.1618607845801;
        Fri, 16 Apr 2021 14:17:25 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id u18sm5444862pfm.4.2021.04.16.14.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 14:17:25 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Fix spurious debugfs directory creation during
 initialization
To:     Saravanan D <saravanand@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tj@kernel.org, kernel-team@fb.com
References: <20210407175958.4129976-1-saravanand@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ab220998-cd24-e8e9-6694-f7143efc744a@kernel.dk>
Date:   Fri, 16 Apr 2021 15:17:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210407175958.4129976-1-saravanand@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/21 11:59 AM, Saravanan D wrote:
> blk_mq_debugfs_register_sched_hctx() called from
> device_add_disk()->elevator_init_mq()->blk_mq_init_sched()
> initialization sequence does not have relevant parent directory
> setup and thus spuriously attempts "sched" directory creation
> from root mount of debugfs for every hw queue detected on the
> block device
> 
> dmesg
> ...
> debugfs: Directory 'sched' with parent '/' already present!
> debugfs: Directory 'sched' with parent '/' already present!
> .
> .
> debugfs: Directory 'sched' with parent '/' already present!
> ...
> 
> The parent debugfs directory for hw queues get properly setup
> device_add_disk()->blk_register_queue()->blk_mq_debugfs_register()
> ->blk_mq_debugfs_register_hctx() later in the block device
> initialization sequence.
> 
> A simple check for debugfs_dir has been added to thwart premature
> debugfs directory/file creation attempts.

Applied, thanks.

-- 
Jens Axboe

