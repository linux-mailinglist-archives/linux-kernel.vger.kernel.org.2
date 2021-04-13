Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA9435E8FF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 00:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbhDMW1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 18:27:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:56218 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231466AbhDMW1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 18:27:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 19045B01E;
        Tue, 13 Apr 2021 22:26:59 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jonathan Corbet <corbet@lwn.net>, Fox Chen <foxhlchen@gmail.com>
Date:   Wed, 14 Apr 2021 08:26:50 +1000
Cc:     Fox Chen <foxhlchen@gmail.com>, vegard.nossum@oracle.com,
        viro@zeniv.linux.org.uk, rdunlap@infradead.org,
        grandmaster@al2klimov.de, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 00/12] docs: path-lookup: Update pathlookup docs
In-Reply-To: <87zgy1rihm.fsf@meer.lwn.net>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
 <87zgy1rihm.fsf@meer.lwn.net>
Message-ID: <875z0p4y8l.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Tue, Apr 13 2021, Jonathan Corbet wrote:

> Fox Chen <foxhlchen@gmail.com> writes:
>
>> The Path lookup is a very complex subject in VFS. The path-lookup
>> document provides a very detailed guidance to help people understand
>> how path lookup works in the kernel. This document was originally
>> written based on three lwn articles five years ago. As times goes by,
>> some of the content is outdated. This patchset is intended to update
>> the document to make it more relevant to current codebase.
>
> Neil, have you had a chance to take a look at these?  I'm reluctant to
> apply them without your ack...

No I haven't, I'm sorry.  And I'm on leave at the moment so my attention
is mostly elsewhere.  However I'll try to make time to have a look
sometime in the next week or so.

Thanks for the prompt.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmB2GqoOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbmQBhAAjeK0yeBn2eBxCF+ynT4NI2ansqT0zrgNusIB
8hdpCGkcPOWbqF1Bnt7IHQWdPJfS8WJfLeQIjhPUKjQpGQ+v1+Udl4rlX7mBRhxp
c1PY2SQorXguc+QFiMNVCE6xGOdZ+AKMrcv4UTdKt15QukR8hMKj8WZW1vnGkgvS
EbHnfExE8LjHYNLL+84yn1KLoWF7Yan9HjS1LwWYS/73aPv4/Sd22Pg1sbT+DExj
9Z1lF+OfaiKtD5yqpcgdWY1DXvcfSdhYzX1cPptHq6xp0wwnSBu2WnlpPBQJM+I+
WLEpPmhCgydWYaONppGSF9g2mYXt5B5x1ch3BfK43fCaJwGrjUvpveosbgCOKUk2
yeXlWSwb7694P69akVwdr2e694+O7bwXklajsz0d9G5/a2g8D3FmgN3305IapfGa
DZrhzfWt67nwlUJ95Ir22XEE5N2SJE835kQL0G52vnoQPw/7PsTQlu2k0g65vUxw
gO+zbdWqXfnRUyiEkovhEsNZxdXHLf4osYl41hFOzJpwdjXLG4jkAcySi+2dfIow
dcIyCAAPYlyurW5VGT1vprxDCSP2To1oBwERF71VfcpyOO3L1niQbFHrhoI8k6Ll
FOQZcEeDGzBXLqHAqACQcTooxiAQhInYd221If0Wl8eVux+EBi3Nhd6UGkEgLqC0
NNFRjCo=
=GW+Q
-----END PGP SIGNATURE-----
--=-=-=--
