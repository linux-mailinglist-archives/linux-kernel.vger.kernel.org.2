Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7CC30B2A9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 23:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhBAWRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 17:17:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:54124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhBAWQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 17:16:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 41FD8AD19;
        Mon,  1 Feb 2021 22:16:16 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Date:   Tue, 02 Feb 2021 09:16:10 +1100
Cc:     mojha@codeaurora.org, jkosina@suse.cz, cezary.rojewski@intel.com,
        neilb@suse.com, b00073877@aus.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] list: add more extensive double add check
In-Reply-To: <YBgnY8FXpHJdoDos@smile.fi.intel.com>
References: <20210201135251.1884-1-christian.koenig@amd.com>
 <YBgnY8FXpHJdoDos@smile.fi.intel.com>
Message-ID: <8735yffn85.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 01 2021, Andy Shevchenko wrote:

> On Mon, Feb 01, 2021 at 02:52:51PM +0100, Christian K=C3=B6nig wrote:
>> Adding the same element to a linked list multiple times
>> seems to be a rather common programming mistake. To debug
>> those I've more than once written some code to check a
>> linked list for duplicates.
>>=20
>> Since re-inventing the wheel over and over again is a bad
>> idea this patch tries to add some common code which allows
>> to check linked lists for duplicates while adding new
>> elements.
>>=20
>> When list debugging is enabled we currently already check
>> the previous and next element if they are identical to the
>> new one. This patch now adds a configuration option to
>> check N elements before and after the desired position.
>>=20
>> By default we still only test one item since testing more
>> means quite a large CPU overhead. This can be overwritten
>> on a per C file bases by defining DEBUG_LIST_DOUBLE_ADD
>> before including list.h.
>
> I'm not sure it is a good idea. Currently the implementation is *generic*.
> You are customizing it w/o letting caller know.
>
> Create a derivative implementation and name it exlist (exclusive list) an=
d use
> whenever it makes sense.
>
> And I think if you are still pushing to modify generic one the default mu=
st be
> 0 in order not altering current behaviour.

I don't understand your complaint.
The extra checks are also completely *generic*.  It can never make sense
to add sometime to a list if it is already on the list.  All lists are
exclusive lists.
The code ALREADY tests if the inserted object is already present either
side of the insert side of the insertion point.  This patch just extends
it somewhat.

I myself have never had, or heard of, a bug due to double insertion so
I'm no strongly in favour of this patch for that reason.
But I *am* in favour of making the platform more resilient in general,
and if others have experienced this sort of bug, then I'm in favour of
make that easier to detect in future.

NeilBrown


>
>> A new kunit test is also added to the existing list tests
>> which intentionally triggers the debug functionality.
>
> --=20
> With Best Regards,
> Andy Shevchenko

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmAYfaoOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigblvpg/+IE41qHY0foFi44tqQ0fhmO7OSXRc+HhmgCeK
4omT7d7cBXOe5bcjQIBrIJbBZmbxOr6LF2KUVXIjRT2BqMsqhqSUvgH9NrGZpvE9
yhnm0U1ud+XHVJ4YZf2+iac/x04nUMeA15B78Zao177HFIqvktExisWFCcAZtsU9
iQAplC422rKJtfPSdzcsDC7cNr698hROORnV9v/tkZiNFg99R1oVn2hXbgyJxL3z
zpJZ04wllSdcQ27mjfQUuoZPMEbpFso5HI32K/R+WCJ29ZdlvdRGzHcMVAtGHIlD
d+kkiDTb1Xz97Zyxzk9W1r10jM8x0lvijH3/lwCwoqxWLpPolhO3x8SvivNs6AGs
7b5y4/VTjWhbGo26ydF1lUl3nDcNJZpH5ulGpfki61CfnkwbirGy0kPDuL9tkLIk
K6bSETco4zbtQlf7LVLQ0gXMTVjiewJcGgKuKFO5Gqeq3cjelIcoD0MaXIkUQbWo
PBYlj+lv4aKDPx+f0NlnnT2XPB98oYOx1MmJOTDiWoRy7xMgWb4aE18hCtspdqAK
+DFjN+w8Ggm+WCU1+JShh4Bmf/IHZgilW6Kj77ibz+SZ5/xfPbdQKFVr/Maagkpb
H3g7MxvjAb4Crzxghb93Iz1f5kyS9HcV2yEkOj/dsqJzDdRakRMg5JwdWyAGOMXy
1kVz0As=
=zjlQ
-----END PGP SIGNATURE-----
--=-=-=--
