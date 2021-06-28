Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1458F3B5AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 11:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhF1JJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 05:09:32 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57066 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbhF1JJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 05:09:30 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 58ABB20239;
        Mon, 28 Jun 2021 09:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624871224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AVHhNegxR+QaaPY+dCc0FenzT0BMI1B1cwtcPQOsEJY=;
        b=QV+xUkDbcbPVWkGQrNuq6S9nSE5cvtqme9uID4htnkkFs3qhWW0GsCqmbH2X0S3nvcz/+U
        GkdMarReT1zJNf9dcutm3RtPvPhBhS04eJpYViBs7F3LHPvaLW3VvHPBDpImox1Dk8VE/y
        bErKFV4FeXNnf6BGxHTo/j70q6yxLiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624871224;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AVHhNegxR+QaaPY+dCc0FenzT0BMI1B1cwtcPQOsEJY=;
        b=j3e6mgXm0IQOmhROuqu5HnO9ScuKHK0s+R0VISejt+twGaoydqdqRgPI7k3hg00gy4Rx76
        YL8GW4OO6ysJtWBw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 3E39C118DD;
        Mon, 28 Jun 2021 09:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624871224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AVHhNegxR+QaaPY+dCc0FenzT0BMI1B1cwtcPQOsEJY=;
        b=QV+xUkDbcbPVWkGQrNuq6S9nSE5cvtqme9uID4htnkkFs3qhWW0GsCqmbH2X0S3nvcz/+U
        GkdMarReT1zJNf9dcutm3RtPvPhBhS04eJpYViBs7F3LHPvaLW3VvHPBDpImox1Dk8VE/y
        bErKFV4FeXNnf6BGxHTo/j70q6yxLiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624871224;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AVHhNegxR+QaaPY+dCc0FenzT0BMI1B1cwtcPQOsEJY=;
        b=j3e6mgXm0IQOmhROuqu5HnO9ScuKHK0s+R0VISejt+twGaoydqdqRgPI7k3hg00gy4Rx76
        YL8GW4OO6ysJtWBw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id VJoMDjiR2WAcUAAALh3uQQ
        (envelope-from <dwagner@suse.de>); Mon, 28 Jun 2021 09:07:04 +0000
Date:   Mon, 28 Jun 2021 11:07:03 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     wenxiong@linux.vnet.ibm.com
Cc:     ming.lei@redhat.com, linux-kernel@vger.kernel.org,
        james.smart@broadcom.com, wenxiong@us.ibm.com
Subject: Re: [PATCH 1/1] block: System crashes when cpu hotplug + bouncing
 port
Message-ID: <20210628090703.apaowrsazl53lza4@beryllium.lan>
References: <1624850072-17776-1-git-send-email-wenxiong@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624850072-17776-1-git-send-email-wenxiong@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wen,

On Sun, Jun 27, 2021 at 10:14:32PM -0500, wenxiong@linux.vnet.ibm.com wrote:
> @@ -468,8 +467,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>  	data.hctx = q->queue_hw_ctx[hctx_idx];
>  	if (!blk_mq_hw_queue_mapped(data.hctx))
>  		goto out_queue_exit;
> -	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
> -	data.ctx = __blk_mq_get_ctx(q, cpu);
> +	data.ctx = __blk_mq_get_ctx(q, hctx_idx);

hctx_idx is just an index, not a CPU id. In this scenario, the hctx_idx
used to lookup the context happens to be valid. I am still a bit
confused why [1] doesn't work for this scenario.

As Ming pointed out in [2] we need to update cpumask for CPU hotplug
events.

Thanks,
Daniel

[1] https://lore.kernel.org/linux-block/20210608183339.70609-1-dwagner@suse.de/
[2] https://lore.kernel.org/linux-nvme/YNXTaUMAFCA84jfZ@T590/
