Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB504205A6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 07:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbhJDGAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 02:00:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:35283 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231935AbhJDGAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 02:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633327086;
        bh=3yQaFDx3HteINXfvXksHTXMue8daiL/SfDc07itzYXc=;
        h=X-UI-Sender-Class:From:To:CC:In-reply-to:Subject:Reply-to:
         References:Date;
        b=C34tpHZ63vLX2lWlplKZFtVaP6QSvYENnT6CFy2STHzNlqVz6XIbbCVYNpsVDRDFW
         BvUgClE9pCVUUxYhMc1YPkYEkWqZf2PTkH9pwOmCoR9ymLNJywMEsPuMdMeYeZNjwq
         N49SJynqauYZwpzibAWPNzLet2y4i1eho40ozId8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from corona.crabdance.com ([173.228.106.131]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M3lYB-1mWzjq2m5T-000wlv; Mon, 04 Oct 2021 07:58:06 +0200
Received: by corona.crabdance.com (Postfix, from userid 1000)
        id C52AD899CC4; Sun,  3 Oct 2021 22:57:58 -0700 (PDT)
From:   Stefan Schaeckeler <schaecsn@gmx.net>
To:     richard@nod.at
CC:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        sschaeck@cisco.com
In-reply-to: <1815586081.32955.1633291105033.JavaMail.zimbra@nod.at> (message
        from Richard Weinberger on Sun, 3 Oct 2021 21:58:25 +0200 (CEST))
Subject: Re: [PATCH 1/1] ubifs: ubifs to export filesystem error counters
Content-Type: text/plain
Reply-to: schaecsn@gmx.net
References: <20210907214034.11676-1-schaecsn@gmx.net> <20210907214034.11676-2-schaecsn@gmx.net> <1815586081.32955.1633291105033.JavaMail.zimbra@nod.at>
Message-Id: <20211004055758.C52AD899CC4@corona.crabdance.com>
Date:   Sun,  3 Oct 2021 22:57:58 -0700 (PDT)
X-Provags-ID: V03:K1:Zg0mDQu0TezbLoYA8pDQR0+RMH3KAnGSWTLtVxSkc71qesyBOPr
 JBAf+vDG++ICxoeTj8f3iQe3YwwWUAK9o9I2YEP0s9tsLe4jckW0gqoysT8GPpP31/HaS2y
 c4dWeRxMxRVkqy+5NQEhJX/4pSLhLYFcGX35nT709N4wJxjXWKjPlOPlaapuoKzNcn+O2mx
 WNnJxPshu06YrrT1JY4gQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mhArpKz+4UI=:iUQjTCYBLI/S7wj60DELtH
 cFRnjvOicAMHcSqcHAjqmlh1flfDRg/Q7Y9EPM+bXDGJfgSiXeydoJ9VcRxi6EBQP03FYY/UC
 RcUaNGJJXW21XPyjlrsHuHx4vGuHFXWegwYSuf7YchEWxq5QPwPXSFvs+HjasRwOnlyCzAjBn
 5UBKL21UnGjmQL/CowHbBfaIujmh3viWS393J1V7ng0MpXIu4MfZg7tp/t0Jy947x4wC+gDYU
 o9FUCcgYbuG1xW60Bwcoj5rDsTPQQquoXG6nS3HiFlhn6iQmJSbBp+dLCQ9A4kEg9EhS6yXXf
 Unhzo8KaIfp9yj+7dkkjTxVt/8HfawXXFVHv9coDRNWHX7RXqpOfgqTTnV47qxB45q5mmOlVR
 wIiUKhLqP4Rf3mGfHhWh3wFFoiTj0JNxMlPJankhQDV/UhHag2A5GzUAvO/527s2zIK4GrJDc
 nKZdImbMDQR21zU1yzYEsnzLefIZBLYvtPHrG8R2TDwBVkwGeG9FQ+iEwgkQHhSNxCwC6WDup
 +eTh8y3h6qrPd0p53CeQ/VYTqmCvbE5UoxrY9WxqdN8hnB2DKYPiJp/pFwzAE8WhSyp4GIhZ9
 WXXD1H/X07ugFbE5J+6OEgB1Ko4Oui2vjGKyDg+go9LF5xzripN8UqOa3INpXspyub/7TO7Ha
 EsXVbsAU2glLfjXt6M1oKCsGl6ecsxX5FMUBE6S121+2yaz9y/AqGY7/0l/lnUYdsGwfDREhE
 r7LE9vMsxk6xdY931+w/mOPs+6EnPG1sZSvPlY1fRvht89qiEkaCCRnEr91hdnwmcd/FBszEd
 rznQuT1vQ88k683h8mjS/xNu7iGc0Y330c1pmbPt9IxCQ0Ea7yYoQ3Nt18foCxEOgQ79vPy6/
 vD9NmCzaSdN/8zzaC3Rsn/SImmCLX3KMgbgXou61OyOWxFEz/W93Uuhsayn0ELAAablDcaOmm
 4uG168dmiSg7swjlleuEKcZH/Nz2FsIaJE10CKoZS+SiaP96a6uj+nwLi3ljhsnK56fwx2+0I
 l68YVuMYw/95VPz4dnDlmoeKp7v0+4uThgCM6eY/Uw+w/o3cyRMzULmfBHkClzy65dwj2GhS0
 VB5OrH7zIvP6cs=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Richard,

> > Not all ubifs filesystem errors are propagated to userspace.
> >
> > Export bad magic, bad node and crc errors via sysfs. This allows users=
pace
> > to notice filesystem errors:
> >
> > /sys/fs/ubifs/ubiX_Y/errors_magic
> > /sys/fs/ubifs/ubiX_Y/errors_node
> > /sys/fs/ubifs/ubiX_Y/errors_crc
> >
> > The counters are reset to 0 with a remount. Writing anything into the
> > counters also clears them.
>
> I think this is a nice feature. Thanks for implementing it.
> Please see some minor nits below.
>
> Is there a specific reason why you didn't implement it via UBIFS's debug=
fs interface?

These error counters are not meant for aiding debugging but for userspace =
to
monitor the sanity of the filesystem. Also ext4 exports error counters via
sysfs - it's probably a good idea to be consistent with them.

$ dir /sys/fs/ext4/sdb2/*error*
-r--r--r-- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/errors_count
-r--r--r-- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/first_error_blo=
ck
-r--r--r-- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/first_error_err=
code
-r--r--r-- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/first_error_fun=
c
-r--r--r-- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/first_error_ino
-r--r--r-- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/first_error_lin=
e
-r--r--r-- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/first_error_tim=
e
-r--r--r-- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/last_error_bloc=
k
-r--r--r-- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/last_error_errc=
ode
-r--r--r-- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/last_error_func
-r--r--r-- 1 root root 4096 Oct  3 13:47 /sys/fs/ext4/sdb2/last_error_ino
-r--r--r-- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/last_error_line
-r--r--r-- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/last_error_time
=2D-w------- 1 root root 4096 Oct  3 13:46 /sys/fs/ext4/sdb2/trigger_fs_er=
ror


> sysfs is ABI, so we cannot change much anymore.

Judging by the filesystem permissions above, ext4 does not seem to allow
resetting error counters. If you worry about unchangable ABIs then we coul=
d
play it safe and don't support write callbacks for resetting the error cou=
nters
in an initial version of the ubifs sysfs. What do you think?

When we are at it, in the current code, writing anything into a sysfs node
resets the corresponding counter. One could fine-tune that to set the coun=
ter
to whatever non-negative integer is passed.


> > +		if (c->stats)
> > +			c->stats->magic_errors++;
>
> Please wrap this into a helper function.

Ack.


> > +		if (c->stats)
> > +			c->stats->node_errors++;
>
> Same.

Ack.


> > +		if (c->stats)
> > +			c->stats->crc_errors++;
>
> Same.

Ack.


> > +#define UBIFS_ATTR_FUNC(_name, _mode) UBIFS_ATTR(_name, _mode, _name)
> > +
> > +UBIFS_ATTR_FUNC(errors_magic, 0644);
> > +UBIFS_ATTR_FUNC(errors_crc, 0644);
> > +UBIFS_ATTR_FUNC(errors_node, 0644);
>
> I'm not sure whether everyone should be allowed to read these stats.
> dmesg is also restricted these days. An unprivileged user should not see=
 the
> errors he can indirectly trigger.

I don't mind 600, but having error counters world-readable is consistent w=
ith
ext4 (see dir above) and so I suggest to keep 644.


> > +	case attr_errors_crc:
> > +		return snprintf(buf, PAGE_SIZE, "%u\n",
> > +				sbi->stats->crc_errors);
>
> Please use sysfs_emit().

Ack.


> > +	if (n =3D=3D UBIFS_DFS_DIR_LEN) {
> > +		/* The array size is too small */
> > +		ret =3D -EINVAL;
> > +		goto out_last;
>
> Where is c->stats released in case of an error?

My fault. Will be fixed.


> > diff --git a/fs/ubifs/sysfs.h b/fs/ubifs/sysfs.h
> > new file mode 100644
> > index 000000000000..a10a82585af8
> > --- /dev/null
> > +++ b/fs/ubifs/sysfs.h
>
> Do we really need a new header file?
> Usually most run-time stuff of UBIFS is part of ubifs.h.

I wanted to be consistent with debugfs where fs/ubifs/debug.c comes with i=
ts
own header fs/ubifs/debug.h.


I'll send out a new patch once we agree on all changes. To recap:

- write callbacks: do we remove them? If not, do we keep them as is or do =
we
  fine-tine them by letting a non-negative integer set the counter?

- 644 (world-readable) counters to be consistent with ext4?

- keep sysfs.h to be consistent with debugfs?

 Stefan
