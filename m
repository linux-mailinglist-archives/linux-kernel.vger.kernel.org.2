Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BDD396E9B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhFAIOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:14:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52318 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbhFAIOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:14:38 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 19B701FD2E;
        Tue,  1 Jun 2021 08:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622535177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qd3AF/dKDwqRf8MMLxL/SDKl0uXw83ifH5FXniQbjkg=;
        b=rwIHbLcCMonwRwRwY6e/sZRnPnOGjsTyH+0PlTmEMr9RaJF6Dv3xAriGByDWOOzjUHX4Jx
        DlgECyYlbM0prPd7HEys3/DBdxllnCN3YkQgp0iIpoBdG5+pCX4H86T/4OKVR4Hhmg/OGr
        GSf2VVIpo7Ir/qwsZC6tcHnB4/5NmYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622535177;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qd3AF/dKDwqRf8MMLxL/SDKl0uXw83ifH5FXniQbjkg=;
        b=+Qc0cDBO22ut006iHHskmjg/FK28DqauNKBw1OxQ7n+hfebOlyZ9tmwjnr8KwfHjj6fRpC
        jjLnUqnkNEaVo5AQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 75138118DD;
        Tue,  1 Jun 2021 08:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622535177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qd3AF/dKDwqRf8MMLxL/SDKl0uXw83ifH5FXniQbjkg=;
        b=rwIHbLcCMonwRwRwY6e/sZRnPnOGjsTyH+0PlTmEMr9RaJF6Dv3xAriGByDWOOzjUHX4Jx
        DlgECyYlbM0prPd7HEys3/DBdxllnCN3YkQgp0iIpoBdG5+pCX4H86T/4OKVR4Hhmg/OGr
        GSf2VVIpo7Ir/qwsZC6tcHnB4/5NmYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622535177;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qd3AF/dKDwqRf8MMLxL/SDKl0uXw83ifH5FXniQbjkg=;
        b=+Qc0cDBO22ut006iHHskmjg/FK28DqauNKBw1OxQ7n+hfebOlyZ9tmwjnr8KwfHjj6fRpC
        jjLnUqnkNEaVo5AQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id ooE1GQjstWDlPQAALh3uQQ
        (envelope-from <osalvador@suse.de>); Tue, 01 Jun 2021 08:12:56 +0000
Date:   Tue, 1 Jun 2021 10:12:54 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,memory_hotplug: Drop unneeded locking
Message-ID: <20210601081250.GA32364@linux>
References: <20210531093958.15021-1-osalvador@suse.de>
 <679d311a-8ad4-bb53-18f0-11190a2bf1b5@arm.com>
 <20210601074737.GA30768@linux>
 <f655ced2-281e-33ee-e1ea-89a0e13fc7a3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f655ced2-281e-33ee-e1ea-89a0e13fc7a3@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: imap.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -0.50
X-Spamd-Result: default: False [-0.50 / 100.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[8];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2]
X-Spam-Flag: NO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 10:02:54AM +0200, David Hildenbrand wrote:
> If there is no writer anymore, why do we have to protect readers?

Yeah, you are right. 
Let me prepare a v2 as this is getting too sloppy.


-- 
Oscar Salvador
SUSE L3
