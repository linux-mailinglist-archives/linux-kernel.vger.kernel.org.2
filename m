Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1CC3B32E4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 17:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhFXP4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 11:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbhFXP4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 11:56:33 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6695C061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 08:54:14 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id v5-20020a0568301bc5b029045c06b14f83so6020534ota.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 08:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OQ3mrMP5A65hndWth+b0LVNbcFy+IhPV+TjaBxR0TZ4=;
        b=JU7KVpNjyD5F7a+L1JBI4+cHo/cPNHomZ/lWoRsz2POOaMNODi6uyM+P7HiBvfN5/L
         OAUrpDsuN93cioDZJl+XdgTNWHErTC1rLX9TwWsj3RSYXtHZAH5loeNF3/FebNz3ZL4d
         qkhL7aLHGdSzfPnJ8B81rJLdQkP/rWkoMghfP31LD6Xt9iZ5wnGvgahJcwtStTNd8mpC
         YtxIPdjonrxmqeuBvyYIm2QDUoURdVT9eJk444Xy1Br4D8YGR8ySM3xTJ3S7UyT/ILXf
         4WzTpOWOaslWmPU5dZrdinHLZxGqpL01ORiECZOUMCct9p1QmyyYCXnBcEmcOzT/8itd
         oMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OQ3mrMP5A65hndWth+b0LVNbcFy+IhPV+TjaBxR0TZ4=;
        b=E5wq4SjMc9+VdtrdmRL7HheTkk/MjCm/Fnr+IPNBipMTlNGDRjoy/Lgq18/Xa9r2BJ
         kx7uwEBaJhG2dckZhJA19uAjwqThIY/zWG7VdwtXM5C5Wusq2Tyo7MrsNnsD2gbKflgR
         xWBxAwQg0ix4F7VHE2GkY0oa1QIT4jryYFM28OAK/lqpB7q38hraoF7JbBBcNorJl7gD
         sznFhMPvm8WURHHvz5rvUWuNDcQg3t6xfkpLgmKM1kZAL3pBTQCOyoWk+RO13AH7YFV6
         Vurx73TzrZtUcKydVwhZmn1vgvzpNl9UniXiW7aAuS9nSe0sP3jQvD0ws+ikEWSp2hvm
         d6NQ==
X-Gm-Message-State: AOAM533I/OEXXFZc5ThgWQimrQMwU/lW0Hj8IH5VUUe9J9+vRfasTjXe
        ryqLj+oroP2gRp72ONVx+lVxRQ==
X-Google-Smtp-Source: ABdhPJz7cFjUzoJofL5Yv52Ws4njxQHN777y/lveN/RFoj4zMUeALrUNA46nEwNzXnDwjZWL4JQ32g==
X-Received: by 2002:a05:6830:15cd:: with SMTP id j13mr5254350otr.147.1624550054100;
        Thu, 24 Jun 2021 08:54:14 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id q5sm356389oti.56.2021.06.24.08.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 08:54:13 -0700 (PDT)
Subject: Re: [PATCH v4] block: fix trace completion for chained bio
To:     edwardh <edwardh@synology.com>, neilb@suse.com, hch@infradead.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        s3t@synology.com, bingjingc@synology.com, cccheng@synology.com,
        Wade Liang <wadel@synology.com>
References: <20210624123030.27014-1-edwardh@synology.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ff63b647-0c0b-e7c7-0daf-499dc358e0dd@kernel.dk>
Date:   Thu, 24 Jun 2021 09:54:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210624123030.27014-1-edwardh@synology.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/21 6:30 AM, edwardh wrote:
> From: Edward Hsieh <edwardh@synology.com>
> 
> For chained bio, trace_block_bio_complete in bio_endio is currently called
> only by the parent bio once upon all chained bio completed.
> However, the sector and size for the parent bio are modified in bio_split.
> Therefore, the size and sector of the complete events might not match the
> queue events in blktrace.
> 
> The original fix of bio completion trace <fbbaf700e7b1> ("block: trace
> completion of all bios.") wants multiple complete events to correspond
> to one queue event but missed this.
> 
> The issue can be reproduced by md/raid5 read with bio cross chunks.
> 
> To fix, move trace completion into the loop for every chained bio to call.

Applied, thanks.

-- 
Jens Axboe

