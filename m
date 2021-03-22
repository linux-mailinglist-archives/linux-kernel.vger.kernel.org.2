Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA08343AE5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 08:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCVHuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 03:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCVHt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:49:58 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76122C061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 00:49:58 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id o5so9620446qkb.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 00:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xdYbX1lteOBwhkyNfi6D2Jmq8cQAJlo4XY28RQPU2sA=;
        b=bkRa+rshm6YMoxJcQkZ0KfWG9jCNHIr/UQhklJG9Rgnhsf64hZdwjSWA4hX8FNbEgN
         IgyvjybD2/S5rpU/X6oaTEnPbFObO+zaCGjvACUk29p9WU6KKvv/E/RQESKyQsuXpggs
         nvTDRT9v6C4KQ6gQ8lMI4ixexwGUNOy0RUGTyBm35gWQejkc0m87KfkU0C9iEeucL9df
         yGK6If9Q6zJN9JwrTV0FPLxVLu15Q/wMhfCxiKDGN0AYjb09b6byfWCYWHvKjmoLnCVR
         awvQ+pW2o5PZD7PG1Zx4tEPtLm1aVk2lT+wORkvAB5Uoi3KjosTiBjKdRzSfBkq9S9C3
         sV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xdYbX1lteOBwhkyNfi6D2Jmq8cQAJlo4XY28RQPU2sA=;
        b=JGlJSpxV3+0BA7gt8U+ROUWVl7Ol1WOVGO4erz9cp0lML3OvmsEeaVV1+QFnNrzcn3
         3i7ftO7H0awp/EK4Mh4e0KfHzb1HiyeFoW1PwHdaDZBvJKcxa5yN5K32qbOUH6qhtGYm
         y80LMwOpirR4Onddv5BvlT2VGN6612XllW5Fm6r0bifYItUjAISrKFIZ5jue8Kz79bJn
         RtWFNZLftvTc12zUbtq8JCBJuAesSYzMfwYJ9j0+5Twa/iJfV1cKK/5F/CJECeOHvAzC
         VLB1Mrzxv7+LkIZgOp0ORnHWvj6efY1PDd28IqYRhHwRqiGHpPcjFEm7V4mJlM+LPwXw
         m+uw==
X-Gm-Message-State: AOAM530xb5/NXaxJOGgLwA/hPSXm6Y+mXxECBV2b5z263RgFvJTpkRek
        cmvd0q+9KFq/I0mWk6k0Q+1Ho0Ko0kydbSVwRWIchQ==
X-Google-Smtp-Source: ABdhPJxAIoJKu7FdQTOldr6rYJb4dltQXuYIwByoH4qJ9DpEFzerNaXUNS5rnknv4fAhRcGJjuUsgmvJra2W9u12NdU=
X-Received: by 2002:a05:620a:410f:: with SMTP id j15mr9877450qko.424.1616399397132;
 Mon, 22 Mar 2021 00:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000053da9405bd7d2644@google.com> <000000000000a17fb305be0b3f38@google.com>
 <20210322071801.GE3440@lst.de>
In-Reply-To: <20210322071801.GE3440@lst.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 22 Mar 2021 08:49:45 +0100
Message-ID: <CACT4Y+bDdmUH4eJV0P7OwT_z1pSi3CWs9fFrtiO89obtK6mpcw@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in disk_part_iter_next (2)
To:     Christoph Hellwig <hch@lst.de>
Cc:     syzbot <syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000e24a1905be1b4ff7"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e24a1905be1b4ff7
Content-Type: text/plain; charset="UTF-8"

On Mon, Mar 22, 2021 at 8:18 AM Christoph Hellwig <hch@lst.de> wrote:
>
> I've been running the reproducer on a KASAN enable VM for about
> 15 minutes now, but haven't been able to reproduce it.
>
> Is there a way to inject this proposed fix into the syzbot queue?

Hi Christoph,

Yes, since this bug has a reproducer, syzbot can test patches. See:

http://bit.do/syzbot#testing-patches

It would be, for example:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master


> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 1a7558917c47d6..f5d5872b89d57e 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -288,15 +288,12 @@ struct device_type part_type = {
>  void delete_partition(struct block_device *part)
>  {
>         xa_erase(&part->bd_disk->part_tbl, part->bd_partno);
> -       kobject_put(part->bd_holder_dir);
> -       device_del(&part->bd_device);
> -
> -       /*
> -        * Remove the block device from the inode hash, so that it cannot be
> -        * looked up any more even when openers still hold references.
> -        */
>         remove_inode_hash(part->bd_inode);
>
> +       synchronize_rcu();
> +
> +       kobject_put(part->bd_holder_dir);
> +       device_del(&part->bd_device);
>         put_device(&part->bd_device);
>  }

--000000000000e24a1905be1b4ff7
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kmkaeeyy0>
X-Attachment-Id: f_kmkaeeyy0

ZGlmZiAtLWdpdCBhL2Jsb2NrL3BhcnRpdGlvbnMvY29yZS5jIGIvYmxvY2svcGFydGl0aW9ucy9j
b3JlLmMKaW5kZXggMWE3NTU4OTE3YzQ3ZDYuLmY1ZDU4NzJiODlkNTdlIDEwMDY0NAotLS0gYS9i
bG9jay9wYXJ0aXRpb25zL2NvcmUuYworKysgYi9ibG9jay9wYXJ0aXRpb25zL2NvcmUuYwpAQCAt
Mjg4LDE1ICsyODgsMTIgQEAgc3RydWN0IGRldmljZV90eXBlIHBhcnRfdHlwZSA9IHsKIHZvaWQg
ZGVsZXRlX3BhcnRpdGlvbihzdHJ1Y3QgYmxvY2tfZGV2aWNlICpwYXJ0KQogewogCXhhX2VyYXNl
KCZwYXJ0LT5iZF9kaXNrLT5wYXJ0X3RibCwgcGFydC0+YmRfcGFydG5vKTsKLQlrb2JqZWN0X3B1
dChwYXJ0LT5iZF9ob2xkZXJfZGlyKTsKLQlkZXZpY2VfZGVsKCZwYXJ0LT5iZF9kZXZpY2UpOwot
Ci0JLyoKLQkgKiBSZW1vdmUgdGhlIGJsb2NrIGRldmljZSBmcm9tIHRoZSBpbm9kZSBoYXNoLCBz
byB0aGF0IGl0IGNhbm5vdCBiZQotCSAqIGxvb2tlZCB1cCBhbnkgbW9yZSBldmVuIHdoZW4gb3Bl
bmVycyBzdGlsbCBob2xkIHJlZmVyZW5jZXMuCi0JICovCiAJcmVtb3ZlX2lub2RlX2hhc2gocGFy
dC0+YmRfaW5vZGUpOwogCisJc3luY2hyb25pemVfcmN1KCk7CisKKwlrb2JqZWN0X3B1dChwYXJ0
LT5iZF9ob2xkZXJfZGlyKTsKKwlkZXZpY2VfZGVsKCZwYXJ0LT5iZF9kZXZpY2UpOwogCXB1dF9k
ZXZpY2UoJnBhcnQtPmJkX2RldmljZSk7CiB9Cg==
--000000000000e24a1905be1b4ff7--
