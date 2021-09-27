Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EF641A2ED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 00:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237739AbhI0Wal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 18:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237679AbhI0Waj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 18:30:39 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D196EC061740
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:29:00 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id d11so21021922ilc.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w9ezsQ1UkQZeC53NkFhy7B+1aNQW9TNDf1kl1c4M4R4=;
        b=Ffjc9XDV39XVuLIm8DJDvOIHuyWwHa/JDveqkJIq4EPQcwwF6i2IwXvqTayH1Zs+J0
         zBBIHTdeujFBpyTsi7j+hLC6dG1lmzreXcsCJibD0ZHuJdAABtpVv3xmIelWiJg4Kiwx
         y74YiDFOoIziOuEp0bFDeka+WbUijbofv2enBSkOGJFIlEwWIxbA3L0TdOIDNHbvW4s3
         UX5WZ/WNqYbm3RB9OdDLcEyEdxxaBYh8+Ce09lqPv5Y/yeoNEYf2H8gl9ZQ2Gx73QUuz
         bK1mNwQj3yvOA8l/cfkBNHF9G4YJ0ALLNw+vW7N07eAC0HlFOVJ1jxEY1tUin9ivF4Jg
         GOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w9ezsQ1UkQZeC53NkFhy7B+1aNQW9TNDf1kl1c4M4R4=;
        b=rFrK/QPeXhQKO95NZnKqlmZjn/xIP0Fl0uwcpdq06M8wFaixU5AoTHihQsWymCBoyU
         yqiswe59Im2mBwCbrlUDBDiFbOag5pmM54Mz8sBhErnHGwdtWYiazVTzfQYlLA9zKrz/
         yvqkvU4r3WgXGL/OIg22f9mfa8rG1o89EhLJD7uqGDBQff12UDgBz5LO23gWcNwzabyh
         BWe4OBpPXlhH2alZfCoRhnRepFRTiyyU+iq3xc786Lid9xKFHpYoGJ8Z0F9jEzCS0g87
         7kgxmBvkjBvBuYUw1MlbjyrgybRnLHG0aUK6iouVgr/X6MYB+2nofecHpCwszojJLLPQ
         HMVA==
X-Gm-Message-State: AOAM533cFHrclJYjK4sNOIuriVumX1mfREMb00fs4aJmqoFnXLwh4DrY
        6fRj9lzBdiu6mlCW/fgdAZcthQ==
X-Google-Smtp-Source: ABdhPJz2QpC01URNtiA6TI68tVS50xc5AHbinQF2wOnvWrWvzOWk+mcoidVwrUAWxR5vBmrTJemKng==
X-Received: by 2002:a05:6e02:661:: with SMTP id l1mr1855976ilt.122.1632781740297;
        Mon, 27 Sep 2021 15:29:00 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id z25sm7614559iow.20.2021.09.27.15.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 15:28:59 -0700 (PDT)
Subject: Re: [PATCH v4 6/6] nbd: add error handling support for add_disk()
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
 <20210927215958.1062466-7-mcgrof@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dc945e14-498b-2cc1-8ef3-8dcaacfb948c@kernel.dk>
Date:   Mon, 27 Sep 2021 16:28:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210927215958.1062466-7-mcgrof@kernel.org>
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

