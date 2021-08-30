Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851533FBAB2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238010AbhH3RPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:15:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43280 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237976AbhH3RPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:15:02 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8446A220E5;
        Mon, 30 Aug 2021 17:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630343647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rHehU4xksFs9Gy3dRgH/qv027selH0oP9fNeJb3sQhY=;
        b=X+ElkcdXgEdT2FDRlqsJtsN4AkaN5LS5dtyc8KtmHPqESK+Lf+TrEGGLOWC7KERLFzYSG5
        V2FMbaUaEmws46JjiPCtifF0WNGEZ59oKTEN9gwD02y2tI9QkILBeuMHv+Q0DstyUOcxP1
        G4i34uSM++hurFY7LAjKKycA/dTtCzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630343647;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rHehU4xksFs9Gy3dRgH/qv027selH0oP9fNeJb3sQhY=;
        b=72bmKQESOjtRUVDv7C1TveyTVR7sd8xGZJaCLvftd+tdN90gG1Uj54CkJOL7Z0jfiHpPVf
        WQ7RFkEjP/hzeMCw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C16901399E;
        Mon, 30 Aug 2021 17:14:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id de5ALdwRLWFRLgAAGKfGzw
        (envelope-from <hare@suse.de>); Mon, 30 Aug 2021 17:14:04 +0000
Subject: Re: [PATCH v1] nvme: avoid race in shutdown namespace removal
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20210830093618.97657-1-dwagner@suse.de>
 <20210830100443.b2zkdp4l3vi2gz42@carbon.lan>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <742108c3-7c76-0bc3-fc13-06acf975c25c@suse.de>
Date:   Mon, 30 Aug 2021 19:14:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210830100443.b2zkdp4l3vi2gz42@carbon.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/21 12:04 PM, Daniel Wagner wrote:
> On Mon, Aug 30, 2021 at 11:36:18AM +0200, Daniel Wagner wrote:
>> Though one thing I am not really sure how it interacts with
>> nvme_init_ns_head() as we could be in running nvme_init_ns_head()
>> after we have set last_path = true. I haven't really figured
>> out yet what this would mean. Is this a real problem?
> 
> I suspect it will regress the very thing 5396fdac56d8 ("nvme: fix
> refcounting imbalance when all paths are down") tried to fix.
> 
Most likely. Do drop me a mail on how to create a reproducer for that; 
it's not exactly trivial as you need to patch qemu for that
(and, of course, those patches will not go upstream as they again hit a 
section which the maintainer deemed to be reworked any time now. So of 
course he can't possibly apply them.)
(I seem to have a particular spell of bad luck, seeing that it's the 
_third_ time this happened to me :-( )

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
