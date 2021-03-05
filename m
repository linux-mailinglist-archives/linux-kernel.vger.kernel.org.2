Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4664C32E8DD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 13:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhCEM3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 07:29:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28546 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232142AbhCEM2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 07:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614947329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SIZLbtAZFPSHx5KKUsWXi2GN4jMwh5B3FLo1HVp/XuA=;
        b=ARrl+A4NacEJoQDWXFN/jTOax3EpcP22OuWcRHEBIWfDrrG+Wr/GiVIgjqcAn7TbGM9mD8
        u/59lfYb6O52NRW/vnzgIkwT0uPrVBPvRuaVVPj7gWjU/NGtsGstM9o54XRkt1nLLmNKbI
        J8eSPvHe2LiO8bFHbbbouJKTK3uZdvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-wSKFs8qaPzSDUFBiJ11oCQ-1; Fri, 05 Mar 2021 07:28:47 -0500
X-MC-Unique: wSKFs8qaPzSDUFBiJ11oCQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 916B283DD20;
        Fri,  5 Mar 2021 12:28:45 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 67AED10013D6;
        Fri,  5 Mar 2021 12:28:45 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 129654BB40;
        Fri,  5 Mar 2021 12:28:42 +0000 (UTC)
Date:   Fri, 5 Mar 2021 07:28:40 -0500 (EST)
From:   Veronika Kabatova <vkabatov@redhat.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Message-ID: <2001895867.30197818.1614947320141.JavaMail.zimbra@redhat.com>
In-Reply-To: <d7470949-0d9d-0863-f5d1-9391134a5e5e@arm.com>
References: <1614921898-4099-1-git-send-email-anshuman.khandual@arm.com> <d7470949-0d9d-0863-f5d1-9391134a5e5e@arm.com>
Subject: Re: [PATCH V3 0/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based
 memory
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.36.114.98, 10.4.195.5]
Thread-Topic: arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory
Thread-Index: HYYsJ7UKXk8vnHFKJgWVD82gr9EAgQ==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
> From: "Anshuman Khandual" <anshuman.khandual@arm.com>
> To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, l=
inux-mm@kvack.org
> Cc: "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kern=
el.org>, "Ard Biesheuvel" <ardb@kernel.org>,
> "Mark Rutland" <mark.rutland@arm.com>, "James Morse" <james.morse@arm.com=
>, "Robin Murphy" <robin.murphy@arm.com>,
> "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>, "Dan Williams" <dan.j.wil=
liams@intel.com>, "David Hildenbrand"
> <david@redhat.com>, "Mike Rapoport" <rppt@linux.ibm.com>, "Veronika Kabat=
ova" <vkabatov@redhat.com>
> Sent: Friday, March 5, 2021 6:38:14 AM
> Subject: Re: [PATCH V3 0/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE bas=
ed memory
>=20
>=20
> On 3/5/21 10:54 AM, Anshuman Khandual wrote:
> > This series fixes pfn_valid() for ZONE_DEVICE based memory and also
> > improves
> > its performance for normal hotplug memory. While here, it also reorgani=
zes
> > pfn_valid() on CONFIG_SPARSEMEM. This series is based on v5.12-rc1.
> >=20
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: James Morse <james.morse@arm.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Mike Rapoport <rppt@linux.ibm.com>
> > Cc: Veronika Kabatova <vkabatov@redhat.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> >=20
> > Changes in V3:
> >=20
> > - Validate the pfn before fetching mem_section with __pfn_to_section() =
in
> > [PATCH 2/2]
>=20
> Hello Veronica,
>=20
> Could you please help recreate the earlier failure [1] but with this
> series applies on v5.12-rc1. Thank you.
>=20

Hello Anshuman,

the machine in question is currently loaned to a developer. I'll reach
out to them and will let you know once I have any results.


Veronika

> [1]
> https://lore.kernel.org/linux-arm-kernel/cki.8D1CB60FEC.K6NJMEFQPV@redhat=
.com/
>=20
> - Anshuman
>=20
>=20

