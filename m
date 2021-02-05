Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD693101AD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 01:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhBEAdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhBEAdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:33:41 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE83C06178A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 16:33:01 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id s107so5293217otb.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 16:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=INZS2fcuimT0BXnMq8wYD1LULx5Le1EEbf7IEopNLx0=;
        b=Pv74m91J/MtiUsZhXSjhl3my4w3thPaYR/MPZIMvXAMCn0QR2O6r43RUadSSK58EN3
         +2f9MWi1GFc6oIXwAVYJUaPYkqeZ/A7bzOYrRvu5mxHMDrlOtoR9KOtRRG0Ac9QNJ5rz
         hX//0EnqtlsOTGkHnc1iZjERuIb2qDv2K/S/VnKDTY02ALSDpG8c3UdTi1u2y/87AHJP
         Myv50khfW6HYd+YlL3CVKj2KVObEvNQYOSF4uBvyYjf9ao45bE2msxy5ly7g91ykBP0l
         jMHhw/2TDgYLsscEHOTVDMzrd1r3STaY7YliD7kTrj0LVzRZmIWFJxnkJyeNt6q4EN1D
         DIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=INZS2fcuimT0BXnMq8wYD1LULx5Le1EEbf7IEopNLx0=;
        b=TpmKDxwrGrUWvx8ZKRklUEHtUIfNo5K4fNyxIL6VmgJCXRFH9QKtY0YQGrtPOQa8HW
         SYMqBa5o33AdyPoOsJK2JGKaLeZOi5U8qVo+2bXNGKp8CrYMjFnwPOkTRMJqXS0es3DN
         ZZnAOH+AvWsHe6wtNTqyI0E1zd7ncQOX4pDomZgQigm+9xRQvdhPbVPCuKsvhLfVeaxG
         Cc0Fh306+DYidj+Ayvs23zFD1BZuGotL8ecSNWrNoTOAuvQKetj0OsyznRckpQiY/dYc
         x8gFM+rGcrFy26pWu4aQs+WLnGYmdg/qZ4Ku87AD7pXTVa21z8fcmPfD+hE+YbstOQ+/
         Bgdw==
X-Gm-Message-State: AOAM530Ag9qq2AZT5lby6yjc1rNONVogvdHvZB7BqijwqAc0e1T70JIj
        ypPE06vwV8EUI3By7f19PGqpGu/EKz/AQg==
X-Google-Smtp-Source: ABdhPJwLG022odMeuq1rlEptv1hjr7dnJyTECz8kl+dG8Q4j+1Z0/fOjUSMTl0P+MGwjskTQkpG/VQ==
X-Received: by 2002:a9d:4c8b:: with SMTP id m11mr1492842otf.319.1612485180362;
        Thu, 04 Feb 2021 16:33:00 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p67sm688791oih.21.2021.02.04.16.32.59
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 04 Feb 2021 16:32:59 -0800 (PST)
Date:   Thu, 4 Feb 2021 16:32:38 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Michal Hocko <mhocko@suse.com>
cc:     Christian Koenig <christian.koenig@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Possible deny of service with memfd_create()
In-Reply-To: <YBwrGNS+Q4JMpuom@dhcp22.suse.cz>
Message-ID: <alpine.LSU.2.11.2102041627040.2796@eggly.anvils>
References: <e7e6231d-8cf9-80a6-7459-5fec9ee547ba@amd.com> <YBwrGNS+Q4JMpuom@dhcp22.suse.cz>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Feb 2021, Michal Hocko wrote:
> On Thu 04-02-21 17:32:20, Christian Koenig wrote:
> > Hi Michal,
> > 
> > as requested in the other mail thread the following sample code gets my test
> > system down within seconds.
> > 
> > The issue is that the memory allocated for the file descriptor is not
> > accounted to the process allocating it, so the OOM killer pics whatever
> > process it things is good but never my small test program.
> > 
> > Since memfd_create() doesn't need any special permission this is a rather
> > nice deny of service and as far as I can see also works with a standard
> > Ubuntu 5.4.0-65-generic kernel.
> 
> Thanks for following up. This is really nasty but now that I am looking
> at it more closely, this is not really different from tmpfs in general.
> You are free to create files and eat the memory without being accounted
> for that memory because that is not seen as your memory from the sysstem
> POV. You would have to map that memory to be part of your rss.
> 
> The only existing protection right now is to use memoery cgroup
> controller because the tmpfs memory is accounted to the process which
> faults the memory in (or write to the file).
> 
> I am not sure there is a good way to handle this in general
> unfortunatelly. Shmem is is just tricky (e.g. how to you deal with left
> overs after the fd is closed?). Maybe memfd_create can be more clever
> and account memory to all owners of the fd but even that sounds far from
> trivial from the accounting POV. It is true that tmpfs can at least
> control who can write to it which is not the case for memfd but then we
> hit the backward compatibility wall.

Yes, no solution satisfactory, and memcg best, but don't forget
echo 2 >/proc/sys/vm/overcommit_memory

Hugh
