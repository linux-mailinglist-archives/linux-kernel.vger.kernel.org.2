Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D52423E81
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 15:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238501AbhJFNTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 09:19:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29238 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231259AbhJFNTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 09:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633526273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+zbCfVnHe3hEOXNTzkBOuBqFXs5HnnXgmi37Lbo5cf0=;
        b=YMqDlv12XO2LnjUUBU7lDeQni7BKIxaMyHTQqVWPWXft4KFCfOMSqL12RVnRMouNTETfmf
        jrWOdwRjrRby3Jy0hPeDmK14VgYTF7la6A9qFIuKrtNXAXeMna7parq+IOeYWqalHw6Byz
        QcrNR6gRllLs4ajMGeE0CkPiRWDi6sI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-fl_FKUOyPnOkVvqX53q8xg-1; Wed, 06 Oct 2021 09:17:52 -0400
X-MC-Unique: fl_FKUOyPnOkVvqX53q8xg-1
Received: by mail-qt1-f200.google.com with SMTP id k1-20020ac80201000000b002a7200b449eso2227597qtg.18
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 06:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+zbCfVnHe3hEOXNTzkBOuBqFXs5HnnXgmi37Lbo5cf0=;
        b=JAZy5ltVeTMbTRqK9bWjtaYj9ocDN5af85ELjsVVqEKT/IKPm2lCf2OImjcSQOBFph
         FidPTBuBAGP/a7XihboFstw5tfz7KCwwQaDKNyGlmpZEiFEO2ptRWdEWaS5ZBir9i/UJ
         B/nCWR8DfLM4bR5Orh0vAFSKASDOYA5bJL+HD5FKEADpYnsAWjJrvTQlBtvFqgIeQd71
         Zfcjs3Mwsl/8VQDhZiSr8Jaboikx3AIy5pnq0xC/nnO0fCmxuz4kcfAyh3I8iF1nWn1K
         QVqm6AoGxJg2d1/OKdXYl4EGRJmbzJ+xEObTfjO7g2ByAX9aWIWX8KIv2/E8bwRQkJnc
         MraA==
X-Gm-Message-State: AOAM5315Pwxii4/kPmdO/HZdj4o7yJWZnBwI3K/Z6efpEIGC2c1MLXml
        Gv7/CYZoQ6Z7wy8aXIDe/DT+4H/5coznzeLRegiwFnIM5uXbHz8SBzR3ngZjnMHi3w5tqGbtCZb
        0RcZjsAShPuj3/fplyXjZF9A=
X-Received: by 2002:a05:622a:180f:: with SMTP id t15mr25944896qtc.314.1633526271470;
        Wed, 06 Oct 2021 06:17:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJ/dfz8opFCb2v5qUfLE0aMcIttTRFyUR16Rj5nDfAcBalXCGeyEeOx/El3NjgM1QYp0hnaw==
X-Received: by 2002:a05:622a:180f:: with SMTP id t15mr25944862qtc.314.1633526271274;
        Wed, 06 Oct 2021 06:17:51 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id r17sm12574405qtx.17.2021.10.06.06.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 06:17:50 -0700 (PDT)
Date:   Wed, 6 Oct 2021 09:17:50 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk, martin.petersen@oracle.com, jejb@linux.ibm.com,
        sagi@grimberg.me, adrian.hunter@intel.com, beanhuo@micron.com,
        ulf.hansson@linaro.org, avri.altman@wdc.com, swboyd@chromium.org,
        agk@redhat.com, josef@toxicpanda.com
Cc:     hch@infradead.org, hare@suse.de, bvanassche@acm.org,
        ming.lei@redhat.com, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mmc@vger.kernel.org,
        dm-devel@redhat.com, nbd@other.debian.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] dm: add add_disk() error handling
Message-ID: <YV2h/iA79JhMJt07@redhat.com>
References: <20210927215958.1062466-1-mcgrof@kernel.org>
 <20210927215958.1062466-5-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927215958.1062466-5-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27 2021 at  5:59P -0400,
Luis Chamberlain <mcgrof@kernel.org> wrote:

> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
> 
> There are two calls to dm_setup_md_queue() which can fail then,
> one on dm_early_create() and we can easily see that the error path
> there calls dm_destroy in the error path. The other use case is on
> the ioctl table_load case. If that fails userspace needs to call
> the DM_DEV_REMOVE_CMD to cleanup the state - similar to any other
> failure.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

