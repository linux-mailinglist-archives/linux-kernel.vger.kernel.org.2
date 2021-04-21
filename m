Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D7B3670D7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 19:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244563AbhDURDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 13:03:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33711 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236712AbhDURDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619024588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IU2gjCTERW+fURIReQ8cOcAZzcEVgLqup7/nNZV9gYw=;
        b=GGkThi0WyPScLTAuDVKW3bzuxJDXwxXRnUoE6bv8OK2bGZHMs6ImzHNzQg09cm2NoYw3LS
        Bno3egxHsRXwy1QXffJG0+v7TR4efZnc5lOzLDqI8mW57ttM22NBJzndm9sogYEi7VkgDy
        sKxZJB/phn4QobEPfJ2XMJAZCTVHF8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-T3YJPoc5PIaWUZFL-3BRpA-1; Wed, 21 Apr 2021 13:03:06 -0400
X-MC-Unique: T3YJPoc5PIaWUZFL-3BRpA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A7141008061;
        Wed, 21 Apr 2021 17:03:05 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FD6060C5F;
        Wed, 21 Apr 2021 17:03:00 +0000 (UTC)
Date:   Wed, 21 Apr 2021 13:02:57 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>
Subject: Re: [PATCH 085/190] Revert "audit: fix a memory leak bug"
Message-ID: <20210421170257.GJ3141668@madcap2.tricolour.ca>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-86-gregkh@linuxfoundation.org>
 <CAHC9VhTvKeNFPsJadVK_i1+qaQBRSVfdWd+HC_EsgZx3coM8oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTvKeNFPsJadVK_i1+qaQBRSVfdWd+HC_EsgZx3coM8oA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-21 12:18, Paul Moore wrote:
> On Wed, Apr 21, 2021 at 9:04 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This reverts commit 70c4cf17e445264453bc5323db3e50aa0ac9e81f.
> >
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> >
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> >
> > Cc: Wenwen Wang <wang6495@umn.edu>
> > Cc: Richard Guy Briggs <rgb@redhat.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  kernel/auditfilter.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> NACK on this revert.  I've looked at the original patch again this
> morning, and the original patch still looks correct and doesn't appear
> to introduce any new faults to the best of my understanding.

Agreed.  Though on review, a much simpler fix to my original patch that
caused this problem requiring this fix
	e85322d21cfebeac64f58a204e9adc0bc5c1e46f rgb 2014-10-02 ("audit: cull redundancy in audit_rule_change")
would have been the two-liner in the error path similar to the pattern
in audit_data_to_entry() error path would have been:

	if (entry->rule.tree)
		audit_put_tree(entry->rule.tree); /* that's the temporary one */

> > diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> > index 333b3bcfc545..19f908b96000 100644
> > --- a/kernel/auditfilter.c
> > +++ b/kernel/auditfilter.c
> > @@ -1125,24 +1125,22 @@ int audit_rule_change(int type, int seq, void *data, size_t datasz)
> >         int err = 0;
> >         struct audit_entry *entry;
> >
> > +       entry = audit_data_to_entry(data, datasz);
> > +       if (IS_ERR(entry))
> > +               return PTR_ERR(entry);
> > +
> >         switch (type) {
> >         case AUDIT_ADD_RULE:
> > -               entry = audit_data_to_entry(data, datasz);
> > -               if (IS_ERR(entry))
> > -                       return PTR_ERR(entry);
> >                 err = audit_add_rule(entry);
> >                 audit_log_rule_change("add_rule", &entry->rule, !err);
> >                 break;
> >         case AUDIT_DEL_RULE:
> > -               entry = audit_data_to_entry(data, datasz);
> > -               if (IS_ERR(entry))
> > -                       return PTR_ERR(entry);
> >                 err = audit_del_rule(entry);
> >                 audit_log_rule_change("remove_rule", &entry->rule, !err);
> >                 break;
> >         default:
> > +               err = -EINVAL;
> >                 WARN_ON(1);
> > -               return -EINVAL;
> >         }
> >
> >         if (err || type == AUDIT_DEL_RULE) {
> > --
> > 2.31.1
> 
> -- 
> paul moore
> www.paul-moore.com
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

