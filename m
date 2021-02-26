Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781B7325CF0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 06:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhBZFPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 00:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhBZFOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 00:14:52 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE21C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 21:14:12 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id h4so5508157pgf.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 21:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=XP1tl4Hv8qsKy1mV1NKF6MqYxY1y0R3nrC5SHGdIwNk=;
        b=vd5aFiZGXu9xC6o/pdUMZanASQ7lgwwFDUIxiH2EghzmDgmfIf6nW16AiDRpv5tIC1
         IV748zScdPdWY8xfrUta0lyD2CgK6GFNEZeepqHwZgdFcPBrp63B0CHAomMjdIvA9CSV
         GK+cEhORkLkn30rJsCHQSdbHI4Sm1SWogtvE9Rapd3IKRaVDBNU/urqcK2dpQU9Wqaek
         jApxcVU/F/2vgqXfqiTvXqpzBbl/HWvrvt3i8G0Lok4fej38PU+msNJ1huBpnixCthqm
         YIXPCnD2OqNrb3sXAD1ji2/vi6M6r8TdpcUA9vAt+oXm0ZQHWoBQPapj533Z1zFJIlVu
         AYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=XP1tl4Hv8qsKy1mV1NKF6MqYxY1y0R3nrC5SHGdIwNk=;
        b=nrQoUhBuZkUrwYJ5NbpogbiiZEdNf4bmj7leuJyunu0IFJc17c9xcSnI5IcSNAN7Xo
         gIUM6odSsKGmk/kowcRSKcV+mAcqPmFwmdLImtaysoNgBi3iFQe24/pfdGjNSQK2P1iq
         prTlcbNvIo/HHVWP3E63oeXienaIvNr2XrB6b9iwAat6YTd+tnzL2bMD4AHOkRtLdcOX
         VS+2thzeykkOSVRlDLuCoSsKkTcSyJXZgitPv1RoCjuu5OEupPTELi4bfyyqNCXtqx3c
         BYkIw01M/rjvRgWh3JmL6+qCkMB/v4LtGhzk241jBd+PVYlxhipgLakQc1A46SvDQTJN
         MJ6g==
X-Gm-Message-State: AOAM532KJ2P9OY0Z/7pP++vqWmgcmAQpoy+z717/N0lohxBYjKNX95+U
        Erz13N9DB6NNIJQsDvz1GRgcZg==
X-Google-Smtp-Source: ABdhPJxy/2GKZso2KcbQLWUAMCO4b2QsXaABUWQj8opEwl3Osvud6EbSbaFFL7g8o9WK3nSFFWG7YQ==
X-Received: by 2002:a62:7bc5:0:b029:1ed:62d5:31f7 with SMTP id w188-20020a627bc50000b02901ed62d531f7mr1559815pfc.24.1614316451509;
        Thu, 25 Feb 2021 21:14:11 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id w187sm7818137pgb.52.2021.02.25.21.14.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Feb 2021 21:14:10 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <24A7BB91-16E7-4C9D-BD80-0B75927AF7B0@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_454B88CC-A469-4B83-B785-9645C1B288C0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] ext4: Handle casefolding with encryption
Date:   Thu, 25 Feb 2021 22:14:07 -0700
In-Reply-To: <CA+PiJmReVX_YXZF1JrfXmothFX7q3iihm2qHyEOGEoYFyrrE5Q@mail.gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Paul Lawrence <paullawrence@google.com>
To:     Daniel Rosenberg <drosen@google.com>
References: <20210203090745.4103054-2-drosen@google.com>
 <56BC7E2D-A303-45AE-93B6-D8921189F604@dilger.ca> <YBrP4NXAsvveIpwA@mit.edu>
 <YCMZSjgUDtxaVem3@mit.edu> <42511E9D-3786-4E70-B6BE-D7CB8F524912@dilger.ca>
 <YCNbIdCsAsNcPuAL@mit.edu>
 <CA+PiJmT2hfdRLztCdp3-tYBqAo+-ibmuyqLvq5nb+asFj4vL7A@mail.gmail.com>
 <YC0/ZsQbKntSpl97@mit.edu> <01918C7B-9D9B-4BD8-8ED1-BA1CBF53CA95@dilger.ca>
 <CA+PiJmReVX_YXZF1JrfXmothFX7q3iihm2qHyEOGEoYFyrrE5Q@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_454B88CC-A469-4B83-B785-9645C1B288C0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Feb 18, 2021, at 4:21 PM, Daniel Rosenberg <drosen@google.com> wrote:
> 
> On Wed, Feb 17, 2021 at 2:48 PM Andreas Dilger <adilger@dilger.ca> wrote:
>> 
>> On Feb 17, 2021, at 9:08 AM, Theodore Ts'o <tytso@mit.edu> wrote:
>>> 
>>> The problem is in how the space after the filename in a directory is
>>> encoded.  The dirdata format is (mildly) expandable, supporting up to
>>> 4 different metadata chunks after the filename, using a very
>>> compatctly encoded TLV (or moral equivalent) scheme.  For directory
>>> inodes that have both the encyption and compression flags set, we have
>>> a single blob which gets used as the IV for the crypto.
>>> 
>>> So it's the difference between a simple blob that is only used for one
>>> thing in this particular case, and something which is the moral
>>> equivalent of simple ASN.1 or protobuf encoding.
>>> 
>>> Currently, datadata has defined uses for 2 of the 4 "chunks", which is
>>> used in Lustre servers.  The proposal which Andreas has suggested is
>>> if the dirdata feature is supported, then the 3rd dirdata chunk would
>>> be used for the case where we currently used by the
>>> encrypted-casefolded extension, and the 4th would get reserved for a
>>> to-be-defined extension mechanism.
>>> 
>>> If there ext4 encrypted/casefold is not yet in use, and we can get the
>>> changes out to all potential users before they release products out
>>> into the field, then one approach would be to only support
>>> encrypted/casefold when dirdata is also enabled.
>>> 
>>> If ext4 encrypted/casefold is in use, my suggestion is that we support
>>> both encrypted/casefold && !dirdata as you have currently implemented
>>> it, and encrypted/casefold && dirdata as Andreas has proposed.
>>> 
>>> IIRC, supporting that Andreas's scheme essentially means that we use
>>> the top four bits in the rec_len field to indicate which chunks are
>>> present, and then for each chunk which is present, there is a 1 byte
>>> length followed by payload.  So that means in the case where it's
>>> encrypted/casefold && dirdata, the required storage of the directory
>>> entry would take one additional byte, plus setting a bit indicating
>>> that the encrypted/casefold dirdata chunk was present.
>> 
>> I think your email already covers pretty much all of the points.
>> 
>> One small difference between current "raw" encrypted/casefold hash vs.
>> dirdata is that the former is 4-byte aligned within the dirent, while
>> dirdata is packed.  So in 3/4 cases dirdata would take the same amount
>> of space (the 1-byte length would use one of the 1-3 bytes of padding
>> vs. the raw format), since the next dirent needs to be aligned anyway.
>> 
>> The other implication here is that the 8-byte hash may need to be
>> copied out of the dirent into a local variable before use, due to
>> alignment issues, but I'm not sure if that is actually needed or not.
>> 
>>> So, no, they aren't incompatible ultimatly, but it might require a
>>> tiny bit more work to integrate the combined support for dirdata plus
>>> encrypted/casefold.  One way we can do this, if we have to support the
>>> current encrypted/casefold format because it's out there in deployed
>>> implementations already, is to integrate encrypted/casefold &&
>>> !dirdata first upstream, and then when we integrate dirdata into
>>> upstream, we'll have to add support for the encrypted/casefold &&
>>> dirdata case.  This means that we'll have two variants of the on-disk
>>> format to test and support, but I don't think it's the going to be
>>> that difficult.
>> 
>> It would be possible to detect if the encrypted/casefold+dirdata
>> variant is in use, because the dirdata variant would have the 0x40
>> bit set in the file_type byte.  It isn't possible to positively
>> identify the "raw" non-dirdata variant, but the assumption would be
>> if (rec_len >= round_up(name_len, 4) + 8) in an encrypted+casefold
>> directory that the "raw" hash must be present in the dirent.
> 
> So sounds like we're going with the combined version. Andreas, do you
> have any suggestions for changes to the casefolding patch to ease the
> eventual merging with dirdata? A bunch of the changes are already
> pretty similar, so some of it is just calling essentially the same
> functions different things.

One thing I would suggest is to change the "is_fake_entry()" from using
offsets in the leaf block to using the content of the dirent to make
that decision.  Comparing entries against "." and ".." is trivial (and
already done in many places), and the checksum entry/tail has a "magic"
file type that can be used.  This will avoid potential problems if e.g.
encrypted entries are stored inline with the inode, and/or dirdata that
also adds fields to "." and "..".

Also, the patch adds the use of "lblk" all around the code, but that
wouldn't be needed if is_fake_entry() was updated as above?

Note in find_group_orlov() the filename hash doesn't strictly need to
match the actual hash used in the directory.  That is only for finding
a suitable group for allocating the inode, so it can be any relatively
uniform hash function and could remain DX_HASH_HALF_MD4.

Cheers, Andreas






--Apple-Mail=_454B88CC-A469-4B83-B785-9645C1B288C0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmA4g58ACgkQcqXauRfM
H+BRXg//fy5o+4ytQgWc8yyRlaMFkOF/GiWN2aDTB3IUxEN9L5gt4fXL3B46na18
8e5RjqrYmxEulFuKWqS49L/IF8hBlUhEWRtBiwt1LxKlEcQXC1AbhGdYDwjdbYUw
1fNaAV32Lq+UyJsNgKP2W6tTY3Bn0kEJepk2XMs0lPMQDubQM3OxueKE8VfA9m2x
gqOPsUC426hm0LqSG5MAJxXSWbc/CYvfyFiBlDse/HkFcgTrHUWmim4cAROz6xPJ
YVtsW91oVur9+IahA0+Vy2qYst989cncJF+6UTIa4dPB5FLaDgoXYrWciuXvpSyN
zILmeR6pHUTxWulkWCmozZ/dCrafPoiy7f0OKIvPHA1BlQlthf31khdzvUO/IYwp
c8zGvhT/Ig0K4dRxNUBOowZN+4tFIP+AcD8j1P4FquEB3LKTcNlnHQlajnGGYMBS
L999E2Zf5PZTNFkO74SXDVxkSH5W61tKCmHf4dLk5Svs2prUWvL44E6UcmsPcqK+
dDQsi3Zq9o9c3do0/4cep6NtpZF2ZadYgOc1bV6lqApOiEkV3vfaCnPIct7MTrrI
9IrYV6awazmVNTgC6l9bEytxwJlJTdmdgIPTXrbZ01Td855Bua3H/DEQIMiYSr3R
RxXWKGR4F/WNwl2HX1yEeBcYv0RgWN8UUEMtH5kbNsyOd53z2gk=
=yJ/1
-----END PGP SIGNATURE-----

--Apple-Mail=_454B88CC-A469-4B83-B785-9645C1B288C0--
