Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1783CF9DA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 14:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbhGTMHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 08:07:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51412 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhGTMHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:07:23 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 16EB222425;
        Tue, 20 Jul 2021 12:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626785281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W1zCtGLplWApScXZ1uLwvVrRWFVgIRci4OmMqdayuVE=;
        b=vkN3BTO/2QXkkbQ1s6QpiIBQHDzgm6xgRvLHLbtfT4qBR82xpCIl4r0CrlAvAwweIfiCuO
        kl6dJfP88trk28PP3u/jYKXcFJoRAEJd8/hzF37jCnWvN41Ff+Robvk7GAh7gCHvbpy68n
        mMJcLnk4Sydmks7HCmRRbPnOc/jMtwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626785281;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W1zCtGLplWApScXZ1uLwvVrRWFVgIRci4OmMqdayuVE=;
        b=HvuRSFGtw8pDIni1fa4Tztt3vw5dqqFZA6WILCWLMahiFoUNmf+J+8ZRixdg3PQXei8tLP
        qLPdwNSSyk+JXGBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id F29EF13AB8;
        Tue, 20 Jul 2021 12:48:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 1mDHOgDG9mBoZQAAGKfGzw
        (envelope-from <dwagner@suse.de>); Tue, 20 Jul 2021 12:48:00 +0000
Date:   Tue, 20 Jul 2021 14:48:00 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 0/6] Handle update hardware queues and queue freeze
 more carefully
Message-ID: <20210720124800.i2lo3hal7kjfc7rk@beryllium.lan>
References: <20210720124353.127959-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720124353.127959-1-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 02:43:47PM +0200, Daniel Wagner wrote:
> v1:
>  - https://lore.kernel.org/linux-nvme/20210625101649.49296-1-dwagner@suse.de/
> v2:
>  - https://lore.kernel.org/linux-nvme/20210708092755.15660-1-dwagner@suse.de/
>  - reviewed tags collected
>  - added 'update hardware queues' for all transport
>  - added fix for fc hanger in nvme_wait_freeze_timeout
> v3:
>  - dropped 'nvme-fc: Freeze queues before destroying them'
>  - added James' two patches

Forgot to add Hannes' reviewed tag. Sorry!
