Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4E43B7017
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 11:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbhF2J3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 05:29:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43342 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbhF2J3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 05:29:48 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 50C9F2265F;
        Tue, 29 Jun 2021 09:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624958840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K4q4LmD7SOlQLXLUrGAnOIJm9Fl0zLoCmgA3rdoB1z0=;
        b=q1u+jMWQ6NgqT1dtiAfWRKU3wKi95ikkm5CIwXjHJDentJ+D0S/3fY20d0rHWJR5r2op3b
        ZKJKWPxgdTcwe9yclmkzsrTopViIQ3fsAw9oPV08lk1117CAt9v1pLuP0DITkZCrRdAx+q
        Ws52nTS1hkvNtiGSYNEVcBHZsPO6HDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624958840;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K4q4LmD7SOlQLXLUrGAnOIJm9Fl0zLoCmgA3rdoB1z0=;
        b=B/b29eDzS5RLMOjf4DSibfCir317dBtBRHNCpdc0DLq+BiK/3aHJJaG879nqgUyHoy5zBO
        y3eHyG04OksKW+Cw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 3764411906;
        Tue, 29 Jun 2021 09:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624958840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K4q4LmD7SOlQLXLUrGAnOIJm9Fl0zLoCmgA3rdoB1z0=;
        b=q1u+jMWQ6NgqT1dtiAfWRKU3wKi95ikkm5CIwXjHJDentJ+D0S/3fY20d0rHWJR5r2op3b
        ZKJKWPxgdTcwe9yclmkzsrTopViIQ3fsAw9oPV08lk1117CAt9v1pLuP0DITkZCrRdAx+q
        Ws52nTS1hkvNtiGSYNEVcBHZsPO6HDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624958840;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K4q4LmD7SOlQLXLUrGAnOIJm9Fl0zLoCmgA3rdoB1z0=;
        b=B/b29eDzS5RLMOjf4DSibfCir317dBtBRHNCpdc0DLq+BiK/3aHJJaG879nqgUyHoy5zBO
        y3eHyG04OksKW+Cw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id WJSGDHjn2mDKXgAALh3uQQ
        (envelope-from <dwagner@suse.de>); Tue, 29 Jun 2021 09:27:20 +0000
Date:   Tue, 29 Jun 2021 11:27:19 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Wen Xiong <wenxiong@us.ibm.com>, james.smart@broadcom.com,
        linux-kernel@vger.kernel.org, sagi@grimberg.me,
        wenxiong@linux.vnet.ibm.com
Subject: Re: [PATCH 1/1] block: System crashes when cpu hotplug + bouncing
 port
Message-ID: <20210629092719.n33t2pnjiwwe6qun@beryllium.lan>
References: <1624850072-17776-1-git-send-email-wenxiong@linux.vnet.ibm.com>
 <20210628090703.apaowrsazl53lza4@beryllium.lan>
 <YNmdhqd+W3XbJCwd@T590>
 <71d1ce491ed5056bfa921f0e14fa646d@imap.linux.ibm.com>
 <OFE573413D.44652DC5-ON00258703.000DB949-00258703.000EFCD4@ibm.com>
 <OF8889275F.DC758B38-ON00258703.001297BC-00258703.00143502@ibm.com>
 <YNqX6w8YHO61oqvY@T590>
 <20210629082542.vm3yh6k36d2zh3k5@beryllium.lan>
 <20210629083549.unco3f7atybqypw3@beryllium.lan>
 <YNrhXFgv/gEWbhbl@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNrhXFgv/gEWbhbl@T590>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 05:01:16PM +0800, Ming Lei wrote:
> No, this way fails the request allocation, which isn't expected from
> NVMe fc/rdma/tcp/loop, since io queue can't be connected in this way.

But __nvme_submit_sync_cmd() can return errors too and they need to be
handled in the connect path. So why is this so special? Not that I am
against your patch, I just like to understand the reasoning.
