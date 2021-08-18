Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6763F03E9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 14:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbhHRMpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 08:45:32 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58108 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbhHRMpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:45:30 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7189E20071;
        Wed, 18 Aug 2021 12:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629290695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TzEdLiDQM8rs0jwtsINY05exG7qfOg7U1lRRWprWkkA=;
        b=WBW7Y00xYUWYhHRfBQ+tUq3eGXIsDtQDbj8iYk2kaVoY9QS/SdUswgkzoe7LIc1kP7IlKS
        uqb6v9asYdywsfZLNiPPlCSTOBg1ZhCsA1oXK+iDJ3bBxSzDeWpxKG0G/sjsVyRbDXD2qp
        S4hE1icbJ5maFY+fgmKiCulau+tDpnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629290695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TzEdLiDQM8rs0jwtsINY05exG7qfOg7U1lRRWprWkkA=;
        b=lmoLbw7jphvHByq06Xn/y8rq0Z3BV+OJJ3EPua0W4GoAw2LRXOQyYXEw0LJrMZeHWtD08o
        uKFqiYMAV/VZ1GCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5F92D1371C;
        Wed, 18 Aug 2021 12:44:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id H8rUFscAHWGnUwAAGKfGzw
        (envelope-from <dwagner@suse.de>); Wed, 18 Aug 2021 12:44:55 +0000
Date:   Wed, 18 Aug 2021 14:44:54 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3] nvme: revalidate paths during rescan
Message-ID: <20210818124454.vcfid2otecdprlsh@carbon.lan>
References: <20210811152803.30017-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811152803.30017-1-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 05:28:03PM +0200, Daniel Wagner wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> When triggering a rescan due to a namespace resize we will be
> receiving AENs on every controller, triggering a rescan of all
> attached namespaces. If multipath is active only the current path and
> the ns_head disk will be updated, the other paths will still refer to
> the old size until AENs for the remaining controllers are received.
> 
> If I/O comes in before that it might be routed to one of the old
> paths, triggering an I/O failure with 'access beyond end of device'.
> With this patch the old paths are skipped from multipath path
> selection until the controller serving these paths has been rescanned.

ping
