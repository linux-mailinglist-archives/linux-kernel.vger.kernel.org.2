Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A3B41A2E9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 00:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbhI0Wa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 18:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237444AbhI0WaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 18:30:25 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CCBC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:28:46 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id s20so24821374ioa.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w9ezsQ1UkQZeC53NkFhy7B+1aNQW9TNDf1kl1c4M4R4=;
        b=Ah7jkIIctR0HcnVgB5sWbeUdZwsGT2EehBK4lb+q32xOVavNWfD82zKlDGRJA1B4PM
         /2U90/0SvcC9l1r+IDSlahEN/NC+QMNdf8OLk/ooOlydqwz6QGg8wDViFrkfEGikp/c3
         /Q8A/XGE1SZVGZ1hcLnLB6Er8MX1tmX3kUoUHTd8fZUIlpDxvC5pwUQYipgCc7oJVSI+
         rkiNvqR6Uh37Z5l+Gj9S3tYzBLrJ2DlUD27NmkKUe2vWKFh1TgA7VLVoziOPGtTGPqo8
         dcSrTDLSWV/lT8K2aextSKUoXJ59tNYXOpE1Usf4pH7xnmSPdZY6piFtoxoW38lIHPW7
         +BBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w9ezsQ1UkQZeC53NkFhy7B+1aNQW9TNDf1kl1c4M4R4=;
        b=UsnxA0D735Bbpn8VFL4pnjsCYUeu9iDn+ovltY4t7UFGXFGsfemIcxwNVIg16pzVsc
         hrk11qhsz9IKKwyNM+/qlbTrfuiDPNJscqfjhPkoic1gWNmMqxnozWfwspSJvU1WmUY+
         BVciFqrs8pkb6q6Wi3gd3FYSP8hgD02mHzHXT7p9P/WiBKAcSxSgybeWh/1ZuXUGtxVm
         d8l6XNuEgC7WdnjlGo5E7vsr7xcWebemSVmQVqf1jg24um0KSMshyBUaIhmTvw2f7jZs
         0TPRTO8Ft9y67xVUkPwO1Hp+AvpgeAhE8FUB6n5ehJAWU2gEs6DCfpxhTi6Hygrui8hO
         XExA==
X-Gm-Message-State: AOAM5316zdVjESZgJWWYBgwpdxFZ7yHfr7InBSg0+0Rm6nor4g87jscy
        KOd9+nM5pmZk7DDOAt27goe4jtswtPBRMA==
X-Google-Smtp-Source: ABdhPJztY3mK3ksoDQMf3OrQ8dUSONHNyLP4EfHo/dO6kIiAhPp9t/W2Pe9f9RD+PJfpbL6A6UQe4w==
X-Received: by 2002:a02:22cf:: with SMTP id o198mr1814887jao.37.1632781726231;
        Mon, 27 Sep 2021 15:28:46 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id e13sm9446741iod.36.2021.09.27.15.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 15:28:45 -0700 (PDT)
Subject: Re: [PATCH v4 5/6] loop: add error handling support for add_disk()
To:     Luis Chamberlain <mcgrof@kernel.org>, martin.petersen@oracle.com,
        jejb@linux.ibm.com, kbusch@kernel.org, sagi@grimberg.me,
        adrian.hunter@intel.com, beanhuo@micron.com,
        ulf.hansson@linaro.org, avri.altman@wdc.com, swboyd@chromium.org,
        agk@redhat.com, snitzer@redhat.com, josef@toxicpanda.com
Cc:     hch@infradead.org, hare@suse.de, bvanassche@acm.org,
        ming.lei@redhat.com, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mmc@vger.kernel.org,
        dm-devel@redhat.com, nbd@other.debian.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210927215958.1062466-1-mcgrof@kernel.org>
 <20210927215958.1062466-6-mcgrof@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1cd6103b-1251-cc22-93ad-da7f207147b4@kernel.dk>
Date:   Mon, 27 Sep 2021 16:28:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210927215958.1062466-6-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/21 3:59 PM, Luis Chamberlain wrote:
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.

Applied, thanks.

-- 
Jens Axboe

