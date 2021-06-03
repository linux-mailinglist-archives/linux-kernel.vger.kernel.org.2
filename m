Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47937399E2E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 11:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhFCJzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 05:55:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48324 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhFCJzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:55:44 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1FB8F219B8;
        Thu,  3 Jun 2021 09:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622714039;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vkOCTa1uijuwFWjRFGt7xUTjPvCPbu7IRw/D3ibgaLs=;
        b=DdpeDuwNQTbJy68rYOlr8IVZ801acHuTm5UT1jDk+GepGFJbNu+VIIDG+ftwGvMhVzfKhp
        LVJeWIdmGeqEfY+Mtiw8xn0VIr2chmMlg5cG0Wtlma0FeQmeC575rotDZq4mDetLD2cIzn
        YMbRfsuNHdnPrcBDVfGuerZOL9QCsRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622714039;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vkOCTa1uijuwFWjRFGt7xUTjPvCPbu7IRw/D3ibgaLs=;
        b=VaEeA7g9ga1D273toLxMtGZmEga2E2Opnv83ApoKrjottaHFWP6jycsrip7ghSMzPXej+s
        TtEJ5j9BjS/a2xDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E0776A3B89;
        Thu,  3 Jun 2021 09:53:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CA00ADA72C; Thu,  3 Jun 2021 11:51:17 +0200 (CEST)
Date:   Thu, 3 Jun 2021 11:51:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] blk-zoned: allow BLKREPORTZONE without CAP_SYS_ADMIN
Message-ID: <20210603095117.GU31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Niklas Cassel <Niklas.Cassel@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210531135444.122018-1-Niklas.Cassel@wdc.com>
 <20210531135444.122018-3-Niklas.Cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531135444.122018-3-Niklas.Cassel@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 01:54:53PM +0000, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> Performing a BLKREPORTZONE operation should be allowed under the same
> permissions as read(). (read() does not require CAP_SYS_ADMIN).
> 
> Remove the CAP_SYS_ADMIN requirement, and instead check that the fd was
> successfully opened with FMODE_READ. This way BLKREPORTZONE will match
> the access control requirement of read().

Does this mean that a process that does not have read nor write access
to the device itself (blocks) is capable of reading the zone
information? Eg. some monitoring tool.
