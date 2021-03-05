Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69EEC32F23E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 19:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhCESRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 13:17:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33672 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229465AbhCESQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 13:16:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614968196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xSmCXVggNB/CHBO3Bg4UxMkncMMlhKiVJCaV9LoD9Ks=;
        b=LxXoB4j2VMWMSIhfPsf10+cOap3COPHzKJ+NkrcsfNCm3aSRGtJ8+rQE4BsOxcGytMnpTf
        YkhxA6zNFYEcAxX/e9tUVjPEJ3BBlbpKTQZzu8KFHSBc3G3BkwQ3bnb53ELVLWzyOiXw6F
        j81VpI0vFtBqA/pFIHrWSbTprPjXDR8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-j6jDLvrLOQGnIWgPki6p7w-1; Fri, 05 Mar 2021 13:16:34 -0500
X-MC-Unique: j6jDLvrLOQGnIWgPki6p7w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75EC01018F64;
        Fri,  5 Mar 2021 18:16:32 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 68F1F19CB0;
        Fri,  5 Mar 2021 18:16:32 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id E213C4BB40;
        Fri,  5 Mar 2021 18:16:31 +0000 (UTC)
Date:   Fri, 5 Mar 2021 13:16:28 -0500 (EST)
From:   Veronika Kabatova <vkabatov@redhat.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Message-ID: <1890909388.30244858.1614968188922.JavaMail.zimbra@redhat.com>
In-Reply-To: <2001895867.30197818.1614947320141.JavaMail.zimbra@redhat.com>
References: <1614921898-4099-1-git-send-email-anshuman.khandual@arm.com> <d7470949-0d9d-0863-f5d1-9391134a5e5e@arm.com> <2001895867.30197818.1614947320141.JavaMail.zimbra@redhat.com>
Subject: Re: [PATCH V3 0/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based
 memory
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.36.114.98, 10.4.195.10]
Thread-Topic: arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory
Thread-Index: HYYsJ7UKXk8vnHFKJgWVD82gr9EAgcl6WMNp
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
> From: "Veronika Kabatova" <vkabatov@redhat.com>
> To: "Anshuman Khandual" <anshuman.khandual@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, l=
inux-mm@kvack.org, "Catalin Marinas"
> <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Ard Biesheuv=
el" <ardb@kernel.org>, "Mark Rutland"
> <mark.rutland@arm.com>, "James Morse" <james.morse@arm.com>, "Robin Murph=
y" <robin.murphy@arm.com>, "J=C3=A9r=C3=B4me Glisse"
> <jglisse@redhat.com>, "Dan Williams" <dan.j.williams@intel.com>, "David H=
ildenbrand" <david@redhat.com>, "Mike
> Rapoport" <rppt@linux.ibm.com>
> Sent: Friday, March 5, 2021 1:28:40 PM
> Subject: Re: [PATCH V3 0/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE bas=
ed memory
>=20
>=20
>=20
> ----- Original Message -----
> > From: "Anshuman Khandual" <anshuman.khandual@arm.com>
> > To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
> > linux-mm@kvack.org
> > Cc: "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon"
> > <will@kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>,
> > "Mark Rutland" <mark.rutland@arm.com>, "James Morse" <james.morse@arm.c=
om>,
> > "Robin Murphy" <robin.murphy@arm.com>,
> > "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>, "Dan Williams"
> > <dan.j.williams@intel.com>, "David Hildenbrand"
> > <david@redhat.com>, "Mike Rapoport" <rppt@linux.ibm.com>, "Veronika
> > Kabatova" <vkabatov@redhat.com>
> > Sent: Friday, March 5, 2021 6:38:14 AM
> > Subject: Re: [PATCH V3 0/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE b=
ased
> > memory
> >=20
> >=20
> > On 3/5/21 10:54 AM, Anshuman Khandual wrote:
> > > This series fixes pfn_valid() for ZONE_DEVICE based memory and also
> > > improves
> > > its performance for normal hotplug memory. While here, it also
> > > reorganizes
> > > pfn_valid() on CONFIG_SPARSEMEM. This series is based on v5.12-rc1.
> > >=20
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: James Morse <james.morse@arm.com>
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: David Hildenbrand <david@redhat.com>
> > > Cc: Mike Rapoport <rppt@linux.ibm.com>
> > > Cc: Veronika Kabatova <vkabatov@redhat.com>
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: linux-mm@kvack.org
> > > Cc: linux-kernel@vger.kernel.org
> > >=20
> > > Changes in V3:
> > >=20
> > > - Validate the pfn before fetching mem_section with __pfn_to_section(=
) in
> > > [PATCH 2/2]
> >=20
> > Hello Veronica,
> >=20
> > Could you please help recreate the earlier failure [1] but with this
> > series applies on v5.12-rc1. Thank you.
> >=20
>=20
> Hello Anshuman,
>=20
> the machine in question is currently loaned to a developer. I'll reach
> out to them and will let you know once I have any results.
>=20

Hi,

I'm happy to report the kernel boots with these new patches. I used the
5.12.0-rc1 kernel (commit 280d542f6ffac0) as a base. The full console log
from the boot process is available at

https://gitlab.com/-/snippets/2086833

in case you want to take a look. Note that there are some call traces
starting around line 3220, but they are NOT introduced by these two
patches and are also present with the base mainline kernel.


Veronika

>=20
> Veronika
>=20
> > [1]
> > https://lore.kernel.org/linux-arm-kernel/cki.8D1CB60FEC.K6NJMEFQPV@redh=
at.com/
> >=20
> > - Anshuman
> >=20
> >=20
>=20

