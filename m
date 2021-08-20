Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9293F2A0B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 12:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbhHTKV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 06:21:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:32790 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238508AbhHTKVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 06:21:22 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A5C622171;
        Fri, 20 Aug 2021 10:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629454844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OhCV0j00jbEuYVNYugRe7kexm9glmlR/zBJJa6VZI4U=;
        b=dYQBJhC8bvYBeWsDKdc369p8UIjCi/fJ55xj/pJKJlaJpiLVCmR646ydbbqyjJ5puNKDS5
        VwP5k2nCKb3waC8KWbMaiIzQN+na/Z1xTGn7d1nKT1KL1YyZCtwzpf6tkgwR51YAlTk7NJ
        hxjHFbNhdO4q6AL1Wc0+TE6V99xMA60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629454844;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OhCV0j00jbEuYVNYugRe7kexm9glmlR/zBJJa6VZI4U=;
        b=gKP2u6eo6H1Yb3VlTBkzw0e+7As9eE+uVMhucrX8nCgXPo5S7mcF+se9wkG/0M4ykwREzU
        giYrZWwh9a7QOUAw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1BD5E13ABF;
        Fri, 20 Aug 2021 10:20:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id sGbcBfyBH2FlZwAAGKfGzw
        (envelope-from <hare@suse.de>); Fri, 20 Aug 2021 10:20:44 +0000
Subject: Re: [PATCH] nvme-tcp: Do not reset transport on data digest errors
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        yi.he@emc.com
References: <20210805121541.77613-1-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <37e801b5-37fe-04d1-77d2-45f397e53206@suse.de>
Date:   Fri, 20 Aug 2021 12:20:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210805121541.77613-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/21 2:15 PM, Daniel Wagner wrote:
> The spec says
> 
>    7.4.6.1 Digest Error handling
> 
>    When a host detects a data digest error in a C2HData PDU, that host
>    shall continue processing C2HData PDUs associated with the command and
>    when the command processing has completed, if a successful status was
>    returned by the controller, the host shall fail the command with a
>    non-fatal transport error.
> 
> Currently the transport is reseted when a data digest error is
> detected. To fix this, keep track of the final status in the queue
> object and use it when completing the request.
> 
> The new member can be placed adjacent to the receive related members and
> fits in the cacheline as there is a 4 byte hole.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
