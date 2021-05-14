Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A725D380373
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 07:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhENFmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 01:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbhENFmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 01:42:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2629EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 22:41:06 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b17so33417747ede.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 22:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=vld0EM5Td8QSdtllG27OwpywTviitekSHv+GerNoer8=;
        b=GWH4txmBNQFb19mWPDARwLR/UXE84fzhGQKfaJDGH3uiHOW00ikq5hRgK5GDx8Ot69
         PJuuJNXC8mzmzbOtvv0E3WXZuZ7k8j4LYshCPEaUHTsKu4ZQSHdGfiBg14ldKjuc9J8L
         2WgaZoPQb251Wcpee8gSzTdHM72Ab4d+ZVBhLscGMnlPhSNLF0Ug6Umo2InfOTbDCobB
         iy2tJQyT/sGUg60udKXj/Sn6BjstAaNq3lujm+OBGy3SYemWSr4/xUlCjaAtckBgRCx1
         UVCRRFi/EibIvjkp+cVBT+F73mddEDeJ5MUFFOxbi3/MRrummqTn61nfR5tgQvWYTa+B
         OzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=vld0EM5Td8QSdtllG27OwpywTviitekSHv+GerNoer8=;
        b=PjiYMDOb93MfIbs31KmznaWu1SkTKOXt+m/MBksWJQ1cHckoGRI8jfj+QxTV0Lnusn
         iUcyk9K1rkauM6X56WwtzipMLSDYFYRxz4/fMUH+6iScBdKFkBi14KlTZ4fOjdDPI+uy
         ckLKovj+kUqHPJAPF2b449WACVUpVm4kDC3M96D4eOGgqvdJLLelLlnAx1ueK6DaaXkA
         oAJ4IuC1kE/MzcNOn8hiBD3noLfKtbMI7G2Qyv9aoaFI9MmNW9N2zyz0ueHzRxXcdStA
         /sZor7Mmdl6PZlhUj7U+3Ko+qXH3eQzaBvZG9qBFlqs9lyB/To81Z0D7vRMIxs7VV0kF
         Ir3A==
X-Gm-Message-State: AOAM533BndlBefy1Whai9hGgdOnCxkYlR6vucctlwhPhe3iYoUHs4UVd
        VebVAJY89gPr4RUuGkvSRL3R4w==
X-Google-Smtp-Source: ABdhPJzR4qbCegL4BJO0qwFWDUpfpaXqG4zQ8s0QEou8BplMihQdGLTSgBHvi25H9kNZPDJKCqa9Qg==
X-Received: by 2002:a05:6402:2714:: with SMTP id y20mr53569437edd.348.1620970864803;
        Thu, 13 May 2021 22:41:04 -0700 (PDT)
Received: from localhost.localdomain (p200300d9970469005bb43495a574ac97.dip0.t-ipconnect.de. [2003:d9:9704:6900:5bb4:3495:a574:ac97])
        by smtp.googlemail.com with ESMTPSA id h9sm3786499ede.93.2021.05.13.22.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 22:41:03 -0700 (PDT)
Subject: Re: ipc/sem, ipc/msg, ipc/mqueue.c kcsan questions
To:     paulmck@kernel.org
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>, 1vier1@web.de
References: <a9b36c77-dc42-4ab2-9740-f27b191dd403@colorfullife.com>
 <20210512201743.GW975577@paulmck-ThinkPad-P17-Gen-1>
 <343390da-2307-442e-8073-d1e779c85eeb@colorfullife.com>
 <20210513190201.GE975577@paulmck-ThinkPad-P17-Gen-1>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <9c9739ec-1273-5137-7b6d-00a27a22ffca@colorfullife.com>
Date:   Fri, 14 May 2021 07:41:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210513190201.GE975577@paulmck-ThinkPad-P17-Gen-1>
Content-Type: multipart/mixed;
 boundary="------------894E4A7E2BB24AC19EC6B0F5"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------894E4A7E2BB24AC19EC6B0F5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/13/21 9:02 PM, Paul E. McKenney wrote:
> On Thu, May 13, 2021 at 08:10:51AM +0200, Manfred Spraul wrote:
>> Hi Paul,
>>
>> On 5/12/21 10:17 PM, Paul E. McKenney wrote:
>> [...]
>>> 	int foo;
>>> 	DEFINE_RWLOCK(foo_rwlock);
>>>
>>> 	void update_foo(int newval)
>>> 	{
>>> 		write_lock(&foo_rwlock);
>>> 		foo = newval;
>>> 		do_something(newval);
>>> 		write_unlock(&foo_rwlock);
>>> 	}
>>>
>>> 	int read_foo(void)
>>> 	{
>>> 		int ret;
>>>
>>> 		read_lock(&foo_rwlock);
>>> 		do_something_else();
>>> 		ret = foo;
>>> 		read_unlock(&foo_rwlock);
>>> 		return ret;
>>> 	}
>>>
>>> 	int read_foo_diagnostic(void)
>>> 	{
>>> 		return data_race(foo);
>>> 	}
>> The text didn't help, the example has helped:
>>
>> It was not clear to me if I have to use data_race() both on the read and the
>> write side, or only on one side.
>>
>> Based on this example: plain C may be paired with data_race(), there is no
>> need to mark both sides.
> Actually, you just demonstrated that this example is quite misleading.
> That data_race() works only because the read is for diagnostic
> purposes.  I am queuing a commit with your Reported-by that makes
> read_foo_diagnostic() just do a pr_info(), like this:
>
> 	void read_foo_diagnostic(void)
> 	{
> 		pr_info("Current value of foo: %d\n", data_race(foo));
> 	}
>
> So thank you for that!

I would not like this change at all.
Assume you chase a rare bug, and notice an odd pr_info() output.
It will take you really long until you figure out that a data_race() 
mislead you.
Thus for a pr_info(), I would consider READ_ONCE() as the correct thing.

What about something like the attached change?

--

     Manfred



--------------894E4A7E2BB24AC19EC6B0F5
Content-Type: text/plain; charset=UTF-8;
 name="access-marking.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="access-marking.txt"

ZGlmZiAtLWdpdCBhL3Rvb2xzL21lbW9yeS1tb2RlbC9Eb2N1bWVudGF0aW9uL2FjY2Vzcy1t
YXJraW5nLnR4dCBiL3Rvb2xzL21lbW9yeS1tb2RlbC9Eb2N1bWVudGF0aW9uL2FjY2Vzcy1t
YXJraW5nLnR4dAppbmRleCAxYWIxODlmNTFmNTUuLjU4ODMyNmI2MDgzNCAxMDA2NDQKLS0t
IGEvdG9vbHMvbWVtb3J5LW1vZGVsL0RvY3VtZW50YXRpb24vYWNjZXNzLW1hcmtpbmcudHh0
CisrKyBiL3Rvb2xzL21lbW9yeS1tb2RlbC9Eb2N1bWVudGF0aW9uL2FjY2Vzcy1tYXJraW5n
LnR4dApAQCAtNjgsNiArNjgsMTEgQEAgUkVBRF9PTkNFKCkgYW5kIFdSSVRFX09OQ0UoKToK
IAogNC4JV3JpdGVzIHNldHRpbmcgdmFsdWVzIHRoYXQgZmVlZCBpbnRvIGVycm9yLXRvbGVy
YW50IGhldXJpc3RpY3MuCiAKK0luIHRoZW9yeSwgcGxhaW4gQy1sYW5ndWFnZSBsb2FkcyBj
YW4gYWxzbyBiZSB1c2VkIGZvciB0aGVzZSB1c2UgY2FzZXMuCitIb3dldmVyLCBpbiBwcmFj
dGljZSB0aGlzIHdpbGwgaGF2ZSB0aGUgZGlzYWR2YW50YWdlIG9mIGNhdXNpbmcgS0NTQU4K
K3RvIGdlbmVyYXRlIGZhbHNlIHBvc2l0aXZlcyBiZWNhdXNlIEtDU0FOIHdpbGwgaGF2ZSBu
byB3YXkgb2Yga25vd2luZwordGhhdCB0aGUgcmVzdWx0aW5nIGRhdGEgcmFjZSB3YXMgaW50
ZW50aW9uYWwuCisKIAogRGF0YS1SYWN5IFJlYWRzIGZvciBBcHByb3hpbWF0ZSBEaWFnbm9z
dGljcwogCkBAIC04NiwxMSArOTEsNiBAQCB0aGF0IGZhaWwgdG8gZXhjbHVkZSB0aGUgdXBk
YXRlcy4gIEluIHRoaXMgY2FzZSwgaXQgaXMgaW1wb3J0YW50IHRvIHVzZQogZGF0YV9yYWNl
KCkgZm9yIHRoZSBkaWFnbm9zdGljIHJlYWRzIGJlY2F1c2Ugb3RoZXJ3aXNlIEtDU0FOIHdv
dWxkIGdpdmUKIGZhbHNlLXBvc2l0aXZlIHdhcm5pbmdzIGFib3V0IHRoZXNlIGRpYWdub3N0
aWMgcmVhZHMuCiAKLUluIHRoZW9yeSwgcGxhaW4gQy1sYW5ndWFnZSBsb2FkcyBjYW4gYWxz
byBiZSB1c2VkIGZvciB0aGlzIHVzZSBjYXNlLgotSG93ZXZlciwgaW4gcHJhY3RpY2UgdGhp
cyB3aWxsIGhhdmUgdGhlIGRpc2FkdmFudGFnZSBvZiBjYXVzaW5nIEtDU0FOCi10byBnZW5l
cmF0ZSBmYWxzZSBwb3NpdGl2ZXMgYmVjYXVzZSBLQ1NBTiB3aWxsIGhhdmUgbm8gd2F5IG9m
IGtub3dpbmcKLXRoYXQgdGhlIHJlc3VsdGluZyBkYXRhIHJhY2Ugd2FzIGludGVudGlvbmFs
LgotCiAKIERhdGEtUmFjeSBSZWFkcyBUaGF0IEFyZSBDaGVja2VkIEFnYWluc3QgTWFya2Vk
IFJlbG9hZAogCkBAIC0xMTAsMTEgKzExMCw2IEBAIHRoYXQgcHJvdmlkZXMgdGhlIGNvbXBp
bGVyIG11Y2ggbGVzcyBzY29wZSBmb3IgbWlzY2hpZXZvdXMgb3B0aW1pemF0aW9ucy4KIENh
cHR1cmluZyB0aGUgcmV0dXJuIHZhbHVlIGZyb20gY21weGNoZygpIGFsc28gc2F2ZXMgYSBt
ZW1vcnkgcmVmZXJlbmNlCiBpbiBtYW55IGNhc2VzLgogCi1JbiB0aGVvcnksIHBsYWluIEMt
bGFuZ3VhZ2UgbG9hZHMgY2FuIGFsc28gYmUgdXNlZCBmb3IgdGhpcyB1c2UgY2FzZS4KLUhv
d2V2ZXIsIGluIHByYWN0aWNlIHRoaXMgd2lsbCBoYXZlIHRoZSBkaXNhZHZhbnRhZ2Ugb2Yg
Y2F1c2luZyBLQ1NBTgotdG8gZ2VuZXJhdGUgZmFsc2UgcG9zaXRpdmVzIGJlY2F1c2UgS0NT
QU4gd2lsbCBoYXZlIG5vIHdheSBvZiBrbm93aW5nCi10aGF0IHRoZSByZXN1bHRpbmcgZGF0
YSByYWNlIHdhcyBpbnRlbnRpb25hbC4KLQogCiBSZWFkcyBGZWVkaW5nIEludG8gRXJyb3It
VG9sZXJhbnQgSGV1cmlzdGljcwogCkBAIC0xMjUsMTEgKzEyMCw5IEBAIHRoYXQgZGF0YV9y
YWNlKCkgbG9hZHMgYXJlIHN1YmplY3QgdG8gbG9hZCBmdXNpbmcsIHdoaWNoIGNhbiByZXN1
bHQgaW4KIGNvbnNpc3RlbnQgZXJyb3JzLCB3aGljaCBpbiB0dXJuIGFyZSBxdWl0ZSBjYXBh
YmxlIG9mIGJyZWFraW5nIGhldXJpc3RpY3MuCiBUaGVyZWZvcmUgdXNlIG9mIGRhdGFfcmFj
ZSgpIHNob3VsZCBiZSBsaW1pdGVkIHRvIGNhc2VzIHdoZXJlIHNvbWUgb3RoZXIKIGNvZGUg
KHN1Y2ggYXMgYSBiYXJyaWVyKCkgY2FsbCkgd2lsbCBmb3JjZSB0aGUgb2NjYXNpb25hbCBy
ZWxvYWQuCi0KLUluIHRoZW9yeSwgcGxhaW4gQy1sYW5ndWFnZSBsb2FkcyBjYW4gYWxzbyBi
ZSB1c2VkIGZvciB0aGlzIHVzZSBjYXNlLgotSG93ZXZlciwgaW4gcHJhY3RpY2UgdGhpcyB3
aWxsIGhhdmUgdGhlIGRpc2FkdmFudGFnZSBvZiBjYXVzaW5nIEtDU0FOCi10byBnZW5lcmF0
ZSBmYWxzZSBwb3NpdGl2ZXMgYmVjYXVzZSBLQ1NBTiB3aWxsIGhhdmUgbm8gd2F5IG9mIGtu
b3dpbmcKLXRoYXQgdGhlIHJlc3VsdGluZyBkYXRhIHJhY2Ugd2FzIGludGVudGlvbmFsLgor
VGhlIGhldXJpc3RpY3MgbXVzdCBiZSBhYmxlIHRvIGhhbmRsZSBhbnkgZXJyb3IuIElmIHRo
ZSBoZXVyaXN0aWNzIGFyZQorb25seSBhYmxlIHRvIGhhbmRsZSBvbGQgYW5kIG5ldyB2YWx1
ZXMsIHRoZW4gV1JJVEVfT05DRSgpL1JFQURfT05DRSgpCittdXN0IGJlIHVzZWQuCiAKIAog
V3JpdGVzIFNldHRpbmcgVmFsdWVzIEZlZWRpbmcgSW50byBFcnJvci1Ub2xlcmFudCBIZXVy
aXN0aWNzCkBAIC0xNDIsMTEgKzEzNSw4IEBAIGR1ZSB0byBjb21waWxlci1tYW5nbGVkIHJl
YWRzLCBpdCBjYW4gYWxzbyB0b2xlcmF0ZSB0aGUgb2NjYXNpb25hbAogY29tcGlsZXItbWFu
Z2xlZCB3cml0ZSwgYXQgbGVhc3QgYXNzdW1pbmcgdGhhdCB0aGUgcHJvcGVyIHZhbHVlIGlz
IGluCiBwbGFjZSBvbmNlIHRoZSB3cml0ZSBjb21wbGV0ZXMuCiAKLVBsYWluIEMtbGFuZ3Vh
Z2Ugc3RvcmVzIGNhbiBhbHNvIGJlIHVzZWQgZm9yIHRoaXMgdXNlIGNhc2UuICBIb3dldmVy
LAotaW4ga2VybmVscyBidWlsdCB3aXRoIENPTkZJR19LQ1NBTl9BU1NVTUVfUExBSU5fV1JJ
VEVTX0FUT01JQz1uLCB0aGlzCi13aWxsIGhhdmUgdGhlIGRpc2FkdmFudGFnZSBvZiBjYXVz
aW5nIEtDU0FOIHRvIGdlbmVyYXRlIGZhbHNlIHBvc2l0aXZlcwotYmVjYXVzZSBLQ1NBTiB3
aWxsIGhhdmUgbm8gd2F5IG9mIGtub3dpbmcgdGhhdCB0aGUgcmVzdWx0aW5nIGRhdGEgcmFj
ZQotd2FzIGludGVudGlvbmFsLgorTm90ZSB0aGF0IEtDU0FOIHdpbGwgb25seSBkZXRlY3Qg
bWFuZ2xlZCB3cml0ZXMgaW4ga2VybmVscyBidWlsdCB3aXRoCitDT05GSUdfS0NTQU5fQVNT
VU1FX1BMQUlOX1dSSVRFU19BVE9NSUM9bi4KIAogCiBVc2Ugb2YgUGxhaW4gQy1MYW5ndWFn
ZSBBY2Nlc3Nlcwo=
--------------894E4A7E2BB24AC19EC6B0F5--
