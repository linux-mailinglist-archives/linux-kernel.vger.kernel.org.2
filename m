Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978573FB38E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbhH3KFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:05:38 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40768 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhH3KFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:05:37 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9E4B91FDE9;
        Mon, 30 Aug 2021 10:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630317883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/BZ9Nzbh36Uo0OVwK8BMQEKq6pKk8VDrZgnYLw2r5LY=;
        b=qeXtqhtrEOPqMzRzjW9t+TL3jD98MhlIpYFJ14zcXaGcQZrNOZmLbncf5x17UL634db6rd
        6zt9q/NPMSYigFoIOBBEtFa0LyjpNJEfDC3wxg+AhGcVnttMXNuBk0DB5nJTJSpQc7qhSG
        2NSpDOIlgfXwxDOzxYehTIXjSfJcg7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630317883;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/BZ9Nzbh36Uo0OVwK8BMQEKq6pKk8VDrZgnYLw2r5LY=;
        b=w9mIVkZ+OuEEu+8qMvcwqgTG2QA7yK6/k+KJ8QRCp1byGlaAS0DamOhqqmcrWNh5Tdu/M9
        7K5DA6/Cs8gmOmCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 8AAEA1365C;
        Mon, 30 Aug 2021 10:04:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id KnbNITutLGEdQAAAGKfGzw
        (envelope-from <dwagner@suse.de>); Mon, 30 Aug 2021 10:04:43 +0000
Date:   Mon, 30 Aug 2021 12:04:43 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v1] nvme: avoid race in shutdown namespace removal
Message-ID: <20210830100443.b2zkdp4l3vi2gz42@carbon.lan>
References: <20210830093618.97657-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830093618.97657-1-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 11:36:18AM +0200, Daniel Wagner wrote:
> Though one thing I am not really sure how it interacts with
> nvme_init_ns_head() as we could be in running nvme_init_ns_head()
> after we have set last_path = true. I haven't really figured
> out yet what this would mean. Is this a real problem?

I suspect it will regress the very thing 5396fdac56d8 ("nvme: fix
refcounting imbalance when all paths are down") tried to fix.
