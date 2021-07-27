Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CF43D756B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 14:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbhG0M5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 08:57:24 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21355 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbhG0M5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 08:57:24 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1627390641; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Ph09f6rm2jcNN4IR0E5c2MFbFILqJFuVJwwa13nyIgNk2zLM1cbayWyeoBs3RhqC6Sd9D/cN1SgQ177xGHJSwnBaZTjUS9vy/XKiBh24ThxEFjp18OuEIFCW9AZnt6ALLL+15b9LQ2Phry0+y4kbYhAaKx6SQVjKdA0gi+T992s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1627390641; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=U3cO4WuqdcXOSb6ekH15gDiYlvqP0dTXsEWCt7m7MZA=; 
        b=BY81B/5YdJmWx4nDi38wstGUQ2xfO9Mg0iTQMWwStR6hP/Q7lX9pJl/PNn9+gBotI3KanA2FZyC0PC33w5xQb7bPM9Aic8ulq+Sd9hQscCOUgx6xxcRpdYfzNnSklnkghCOWdU2GI66H4x12jeaKFKlqjCnXFNWSUhvlcTnXpcU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1627390641;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=U3cO4WuqdcXOSb6ekH15gDiYlvqP0dTXsEWCt7m7MZA=;
        b=PQCwMaDqBqA4KOs89/0+QBRkWD2sWHk6b1lhA93S1665TvJ8GSTz+8yR8cd1j+p9
        0iuvyO5DqKbO8x9edYDw/UTpOQSKeIszaEUk4Ndk11AQpyoh6wGgBbwloxXYax8XpyT
        8TfTe1W5Bz7v5SQx098++e6sCCFhYXKKtScK2TG0=
Received: from anirudhrb.com (49.207.59.170 [49.207.59.170]) by mx.zohomail.com
        with SMTPS id 1627390638851237.21820913776628; Tue, 27 Jul 2021 05:57:18 -0700 (PDT)
Date:   Tue, 27 Jul 2021 18:27:06 +0530
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+de271708674e2093097b@syzkaller.appspotmail.com
Subject: Re: [PATCH v7 2/2] firmware_loader: fix use-after-free in
 firmware_fallback_sysfs
Message-ID: <YQACopP/tRsLFQVJ@anirudhrb.com>
References: <20210724121134.6364-1-mail@anirudhrb.com>
 <20210724121134.6364-3-mail@anirudhrb.com>
 <20210726182721.3no7ql73ggttdiyx@garbanzo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726182721.3no7ql73ggttdiyx@garbanzo>
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 11:27:21AM -0700, Luis Chamberlain wrote:
> On Sat, Jul 24, 2021 at 05:41:34PM +0530, Anirudh Rayabharam wrote:
> > This use-after-free happens when a fw_priv object has been freed but
> > hasn't been removed from the pending list (pending_fw_head). The next
> > time fw_load_sysfs_fallback tries to insert into the list, it ends up
> > accessing the pending_list member of the previoiusly freed fw_priv.
> > 
> > The root cause here is that all code paths that abort the fw load
> > don't delete it from the pending list. For example:
> > 
> > 	_request_firmware()
> > 	  -> fw_abort_batch_reqs()
> > 	      -> fw_state_aborted()
> > 
> > To fix this, delete the fw_priv from the list in __fw_set_state() if
> > the new state is DONE or ABORTED. This way, all aborts will remove
> > the fw_priv from the list. Accordingly, remove calls to list_del_init
> > that were being made before calling fw_state_(aborted|done).
> > 
> > Also, in fw_load_sysfs_fallback, don't add the fw_priv to the pending
> > list if it is already aborted. Instead, just jump out and return early.
> > 
> > Fixes: bcfbd3523f3c ("firmware: fix a double abort case with fw_load_sysfs_fallback")
> > Reported-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
> > Tested-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
> 
> Curious, how do you get syzbot to test this, I mean your custom tree?

Don't need a custom tree. You can send syzbot the git url of an existing
tree (such as linux-next or Linus' tree) and a patch to apply on that
tree before testing. This is documented here:

https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches

Of course, using a custom tree is also possible.

> 
> > Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> 
> With the changes Shua requested being made:

I'll implement Shua's suggestions and send a new version.

Thanks!

	- Anirudh.

> 
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> 
>   Luis
