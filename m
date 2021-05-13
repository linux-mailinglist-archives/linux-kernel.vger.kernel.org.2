Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA08E37F2D6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 08:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhEMGMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 02:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhEMGMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 02:12:05 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF15FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 23:10:54 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n84so14057398wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 23:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=Iym9nl8hxVptAjnCNKSYtBku3Ry55aXWZ53H7Q29L9o=;
        b=VW0M74vSF8QB/mvjCSNPxX1lRAI8wtfY262Tmh08lF3nPkSJL0FEHLNZHlPK3i1u9M
         A+BQ1wXk+fYBTrclVjiSgNQFZ83H4/sKrycetoKFFLF2Cc75eSK9UJoDJC5Ub47yrKFB
         HCkWS0bod7c9UisDRB9LC9nLLD+Ani5IsR16XvMWvMxRDOH/sCZNsw2dEvexapISk4k4
         oUxofDp6Wq1dOdCwbSThnPBrpG+8TS50u4aV0y2kf6XWgUW8H2K4n4/noEXxwQ3pD9do
         5SE81IUwP83+Pp6AcDpVHGLu/U3F1zJiW8d9iqQAxw9vd2AGX7FCPdGGNcLGj2gHPpGG
         wUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=Iym9nl8hxVptAjnCNKSYtBku3Ry55aXWZ53H7Q29L9o=;
        b=JPXlTN/2dox0G97CQ7lW6UQKp6WFD8o+SH60eI3xsVbW1uT/MN11lscnyeKmLo/xGG
         7Ke8vJAtG0QWweGDv9XT7beoWZVCLBEsQJt090rmLRsiTbRrATbsnXFMPG5qI7eqJ8U6
         mH5JE4gMHIO2eYjjWlMjt7DyPDWqw1kOoTjheCMo1Im002sz9bDPfTmZHHR7Lj3YAM2/
         fa5WqVbGczSwjSVAMT8DNApxPRLFwfe/saaLD7HRYkEqufqT9uKAjHlEbjxqoBK7reos
         3EH2xXk0oU119bQmgHzkpziXqTiEiF3dCVGqkOjSHOGcVfxMXp0zEtCDndO3N8W5oHxr
         lUbA==
X-Gm-Message-State: AOAM530bJXu78CnrwaNPLi86cJ8DDX83zUK1y2/Q6ZJCO7sgnLvHYMoO
        uHzX4VtaN+oW74aMaCX0ZD+kZQ==
X-Google-Smtp-Source: ABdhPJyxe+ZcuNwoc4sqqgpJ5Nh2ZwvjnC4uOL3wpEScXmJAQAqnCXWymhKLs5BxB6w36DeqtFmsGA==
X-Received: by 2002:a1c:48e:: with SMTP id 136mr1736040wme.166.1620886253676;
        Wed, 12 May 2021 23:10:53 -0700 (PDT)
Received: from localhost.localdomain (p200300d9970517000139f30f0798d643.dip0.t-ipconnect.de. [2003:d9:9705:1700:139:f30f:798:d643])
        by smtp.googlemail.com with ESMTPSA id 15sm1440857wmj.28.2021.05.12.23.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 23:10:52 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
Subject: Re: ipc/sem, ipc/msg, ipc/mqueue.c kcsan questions
To:     paulmck@kernel.org
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>, 1vier1@web.de
References: <a9b36c77-dc42-4ab2-9740-f27b191dd403@colorfullife.com>
 <20210512201743.GW975577@paulmck-ThinkPad-P17-Gen-1>
Message-ID: <343390da-2307-442e-8073-d1e779c85eeb@colorfullife.com>
Date:   Thu, 13 May 2021 08:10:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210512201743.GW975577@paulmck-ThinkPad-P17-Gen-1>
Content-Type: multipart/mixed;
 boundary="------------7E09A4E938C7783C55499CA3"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7E09A4E938C7783C55499CA3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Paul,

On 5/12/21 10:17 PM, Paul E. McKenney wrote:
> On Wed, May 12, 2021 at 09:58:18PM +0200, Manfred Spraul wrote:
>> [...]
>> sma->use_global_lock is evaluated in sem_lock() twice:
>>
>>>         /*
>>>           * Initial check for use_global_lock. Just an optimization,
>>>           * no locking, no memory barrier.
>>>           */
>>>          if (!sma->use_global_lock) {
>> Both sides of the if-clause handle possible data races.
>>
>> Is
>>
>>      if (!data_race(sma->use_global_lock)) {
>>
>> the correct thing to suppress the warning?
> Most likely READ_ONCE() rather than data_race(), but please see
> the end of this message.

Based on the document, I would say data_race() is sufficient:

I have replaced the code with "if (jiffies %2)", and it runs fine.

Thus I don't see which evil things a compiler could do, ... .

[...]

Does tools/memory-model/Documentation/access-marking.txt, shown below,
> help?
>
[...]
> 	int foo;
> 	DEFINE_RWLOCK(foo_rwlock);
>
> 	void update_foo(int newval)
> 	{
> 		write_lock(&foo_rwlock);
> 		foo = newval;
> 		do_something(newval);
> 		write_unlock(&foo_rwlock);
> 	}
>
> 	int read_foo(void)
> 	{
> 		int ret;
>
> 		read_lock(&foo_rwlock);
> 		do_something_else();
> 		ret = foo;
> 		read_unlock(&foo_rwlock);
> 		return ret;
> 	}
>
> 	int read_foo_diagnostic(void)
> 	{
> 		return data_race(foo);
> 	}

The text didn't help, the example has helped:

It was not clear to me if I have to use data_race() both on the read and 
the write side, or only on one side.

Based on this example: plain C may be paired with data_race(), there is 
no need to mark both sides.


Attached is a dummy change to ipc/sem.c, where I have added comments to 
every access.

If data_race() is sufficient, then I think I have understood the rules, 
and I would recheck ipc/*.c and the netfilter code.


--

     Manfred



--------------7E09A4E938C7783C55499CA3
Content-Type: text/plain; charset=UTF-8;
 name="ipc-sem-dummy-change"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="ipc-sem-dummy-change"

ZGlmZiAtLWdpdCBhL2lwYy9zZW0uYyBiL2lwYy9zZW0uYwppbmRleCBiZjUzNGM3NDI5M2Uu
LjYwMjYxODdmNzlmOCAxMDA2NDQKLS0tIGEvaXBjL3NlbS5jCisrKyBiL2lwYy9zZW0uYwpA
QCAtODcsNiArODcsNyBAQAogI2luY2x1ZGUgPGxpbnV4L3NjaGVkL3dha2VfcS5oPgogI2lu
Y2x1ZGUgPGxpbnV4L25vc3BlYy5oPgogI2luY2x1ZGUgPGxpbnV4L3JoYXNodGFibGUuaD4K
KyNpbmNsdWRlIDxsaW51eC9qaWZmaWVzLmg+CiAKICNpbmNsdWRlIDxsaW51eC91YWNjZXNz
Lmg+CiAjaW5jbHVkZSAidXRpbC5oIgpAQCAtMzM2LDIwICszMzcsNDMgQEAgc3RhdGljIHZv
aWQgY29tcGxleG1vZGVfZW50ZXIoc3RydWN0IHNlbV9hcnJheSAqc21hKQogCWludCBpOwog
CXN0cnVjdCBzZW0gKnNlbTsKIAorCS8qIGNhbGxlciBvd25zIHNlbV9wZXJtLmxvY2sgLT4g
cGxhaW4gQyBhY2Nlc3MgKi8KIAlpZiAoc21hLT51c2VfZ2xvYmFsX2xvY2sgPiAwKSAgewog
CQkvKgogCQkgKiBXZSBhcmUgYWxyZWFkeSBpbiBnbG9iYWwgbG9jayBtb2RlLgogCQkgKiBO
b3RoaW5nIHRvIGRvLCBqdXN0IHJlc2V0IHRoZQogCQkgKiBjb3VudGVyIHVudGlsIHdlIHJl
dHVybiB0byBzaW1wbGUgbW9kZS4KIAkJICovCisJCS8qIGEgY2hhbmdlIGZyb20gYSBub24t
emVybyB2YWx1ZSB0byBhbm90aGVyCisJCSAqIG5vbi16ZXJvIHZhbHVlLiBQbGFpbiBDIGlz
IHN1ZmZpY2llbnQsIGFzIGFsbAorCQkgKiByZWFkZXJzIGVpdGhlciBvd24gc2VtX3Blcm0u
bG9jayBvciBhcmUgdXNpbmcKKwkJICogZGF0YV9yYWNlKCkgb3Igc21wX2xvYWRfYWNxdWly
ZSgpLgorCQkgKi8KIAkJc21hLT51c2VfZ2xvYmFsX2xvY2sgPSBVU0VfR0xPQkFMX0xPQ0tf
SFlTVEVSRVNJUzsKIAkJcmV0dXJuOwogCX0KKwkvKiBRdWVzdGlvbjogVGhpcyBwYWlycyB3
aXRoIHRoZSBzbXBfbG9hZF9hY3F1aXJlCisJICogaW4gc2VtX2xvY2soKSwgaW4gYSByYWN5
IHdheToKKwkgKiBUaGUgcmVhZGVyIGluIHNlbV9sb2NrKCkgbWF5IHNlZSB0aGUgbmV3IHZh
bHVlCisJICogaW1tZWRpYXRlbHksIC4uLgorCSAqLwogCXNtYS0+dXNlX2dsb2JhbF9sb2Nr
ID0gVVNFX0dMT0JBTF9MT0NLX0hZU1RFUkVTSVM7CiAKIAlmb3IgKGkgPSAwOyBpIDwgc21h
LT5zZW1fbnNlbXM7IGkrKykgewogCQlzZW0gPSAmc21hLT5zZW1zW2ldOwogCQlzcGluX2xv
Y2soJnNlbS0+bG9jayk7CisJCS8qIC4uLiwgb3IgbXVjaCBsYXRlci4KKwkJICogQnV0IHRo
aXMgaXMgdGhlIGxhdGVzdCBwb3NzaWJsZSB0aW1lOgorCQkgKiBzZW1fbG9jaygpIG93bnMg
b25lIG9mIHRoZSBzZW0tPmxvY2sgbG9ja3MKKwkJICogd2hlbiB1c2luZyBzbXBfbG9hZF9h
Y3F1aXJlKCkuIFRodXMgb25lIG9mIHRoZQorCQkgKiBzcGluX3VubG9jaygpcyBpbiB0aGlz
IGxvb3AgaXMgdGhlIF9yZWxlYXNlIGZvcgorCQkgKiB0aGUgcGxhaW4gQyB3cml0ZSBhYm92
ZS4KKwkJICogTXkgY3VycmVudCB1bmRlcnN0YW5kaW5nOiBQbGFpbiBDIGlzIGNvcnJlY3Qs
CisJCSAqIGFzIHRoZSByZWFkZXIgaXMgZWl0aGVyIHVzaW5nIGRhdGFfcmFjZSgpIG9yCisJ
CSAqIHNtcF9sb2FkX2FjcXVpcmUoKSwgb3IgaXQgaXMgYSB0cml2aWFsIGNhc2UKKwkJICog
b2YgdGhlIHJlYWRlciBvd25zIHNlbV9wZXJtLmxvY2sgLSBhbmQgd2Ugb3duCisJCSAqIHRo
YXQgbG9jayBhbGwgdGhlIHRpbWUuCisJCSAqLwogCQlzcGluX3VubG9jaygmc2VtLT5sb2Nr
KTsKIAl9CiB9CkBAIC0zNjYsMTEgKzM5MCwyMSBAQCBzdGF0aWMgdm9pZCBjb21wbGV4bW9k
ZV90cnlsZWF2ZShzdHJ1Y3Qgc2VtX2FycmF5ICpzbWEpCiAJCSAqLwogCQlyZXR1cm47CiAJ
fQorCS8qIHNlbV9wZXJtLmxvY2sgb3duZWQsIGFuZCBhbGwgd3JpdGVzIHRvIHNtYS0+dXNl
X2dsb2JhbF9sb2NrCisJICogaGFwcGVuIHVuZGVyIHRoYXQgbG9jayAtPiBwbGFpbiBDCisJ
ICovCiAJaWYgKHNtYS0+dXNlX2dsb2JhbF9sb2NrID09IDEpIHsKIAogCQkvKiBTZWUgU0VN
X0JBUlJJRVJfMSBmb3IgcHVycG9zZS9wYWlyaW5nICovCiAJCXNtcF9zdG9yZV9yZWxlYXNl
KCZzbWEtPnVzZV9nbG9iYWxfbG9jaywgMCk7CiAJfSBlbHNlIHsKKwkJLyogdGhlIHJlYWQg
c2lkZSBpcyBtYWtlZCAtPiBwbGFpbiBDLgorCQkgKiBRdWVzdGlvbjogT2xkIHZhbHVlIDQs
IG5ldyB2YWx1ZSAzLgorCQkgKiBJZiBpdCBtaWdodCBoYXBwZW4gdGhhdCB0aGUgYWN0dWFs
CisJCSAqIGNoYW5nZSBpcyA0IC0+IDAgLT4gMyAoaS5lLiBmaXJzdDoKKwkJICogY2xlYXIg
Yml0IDIsIHRoZW4gc2V0IGJpdHMgMCYxLCB0aGVuCisJCSAqIHRoaXMgd291bGQgYnJlYWsg
dGhlIGFsZ29yaXRobS4KKwkJICogSXMgdGhlcmVmb3JlIFdSSVRFX09OQ0UoKSByZXF1aXJl
ZD8gKi8KIAkJc21hLT51c2VfZ2xvYmFsX2xvY2stLTsKIAl9CiB9CkBAIC00MTIsNyArNDQ2
LDIwIEBAIHN0YXRpYyBpbmxpbmUgaW50IHNlbV9sb2NrKHN0cnVjdCBzZW1fYXJyYXkgKnNt
YSwgc3RydWN0IHNlbWJ1ZiAqc29wcywKIAkgKiBJbml0aWFsIGNoZWNrIGZvciB1c2VfZ2xv
YmFsX2xvY2suIEp1c3QgYW4gb3B0aW1pemF0aW9uLAogCSAqIG5vIGxvY2tpbmcsIG5vIG1l
bW9yeSBiYXJyaWVyLgogCSAqLwotCWlmICghc21hLT51c2VfZ2xvYmFsX2xvY2spIHsKKyNp
ZiAxCisJLyogdGhlIGNvZGUgd29ya3MgZmluZSByZWdhcmRsZXNzIG9mIHRoZSByZXR1cm5l
ZCB2YWx1ZQorCSAqIC0+IGRhdGFfcmFjZSgpLgorCSAqLworCWlmICghZGF0YV9yYWNlKHNt
YS0+dXNlX2dsb2JhbF9sb2NrKSkgeworI2Vsc2UKKwkvKiBwcm9vZiBvZiB0aGUgY2xhaW0g
dGhhdCB0aGUgY29kZSBhbHdheXMgd29ya3M6CisJICogTXkgYmVuY2htYXJrcyByYW4gZmlu
ZSB3aXRoIHRoaXMgaW1wbGVtZW50YXRpb24gOi0pCisJICovCisJaWYgKGppZmZpZXMlMikg
eworCQlwcl9pbmZvKCJqaWZmaWVzIG1vZCAyIGlzIDEuXG4iKTsKKwl9IGVsc2UgeworCQlw
cl9pbmZvKCJqaWZmaWVzIG1vZCAyIGlzIDAuXG4iKTsKKyNlbmRpZgogCQkvKgogCQkgKiBJ
dCBhcHBlYXJzIHRoYXQgbm8gY29tcGxleCBvcGVyYXRpb24gaXMgYXJvdW5kLgogCQkgKiBB
Y3F1aXJlIHRoZSBwZXItc2VtYXBob3JlIGxvY2suCkBAIC00MjAsNiArNDY3LDExIEBAIHN0
YXRpYyBpbmxpbmUgaW50IHNlbV9sb2NrKHN0cnVjdCBzZW1fYXJyYXkgKnNtYSwgc3RydWN0
IHNlbWJ1ZiAqc29wcywKIAkJc3Bpbl9sb2NrKCZzZW0tPmxvY2spOwogCiAJCS8qIHNlZSBT
RU1fQkFSUklFUl8xIGZvciBwdXJwb3NlL3BhaXJpbmcgKi8KKwkJLyogc21hLT51c2VfZ2xv
YmFsX2xvY2sgaXMgd3JpdHRlbiB0byB3aXRoIHBsYWluIEMKKwkJICogd2l0aGluIGEgc3Bp
bmxvY2sgcHJvdGVjdGVkIHJlZ2lvbiAoYnV0OiBhbm90aGVyCisJCSAqIGxvY2ssIG5vdCB0
aGUgc2VtLT5sb2NrIHRoYXQgd2Ugb3duKS4gTm8gbmVlZAorCQkgKiBmb3IgZGF0YV9yYWNl
KCksIGFzIHdlIHVzZSBzbXBfbG9hZF9hY3F1aXJlKCkuCisJCSAqLwogCQlpZiAoIXNtcF9s
b2FkX2FjcXVpcmUoJnNtYS0+dXNlX2dsb2JhbF9sb2NrKSkgewogCQkJLyogZmFzdCBwYXRo
IHN1Y2Nlc3NmdWwhICovCiAJCQlyZXR1cm4gc29wcy0+c2VtX251bTsKQEAgLTQzMCw2ICs0
ODIsMTAgQEAgc3RhdGljIGlubGluZSBpbnQgc2VtX2xvY2soc3RydWN0IHNlbV9hcnJheSAq
c21hLCBzdHJ1Y3Qgc2VtYnVmICpzb3BzLAogCS8qIHNsb3cgcGF0aDogYWNxdWlyZSB0aGUg
ZnVsbCBsb2NrICovCiAJaXBjX2xvY2tfb2JqZWN0KCZzbWEtPnNlbV9wZXJtKTsKIAorCS8q
IFRyaXZpYWwgY2FzZTogQWxsIHdyaXRlcyB0byBzbWEtPnVzZV9nbG9iYWxfbG9jayBoYXBw
ZW4gdW5kZXIKKwkgKiBzbWEtPnNlbV9wZXJtLmxvY2suIFdlIG93biB0aGF0IGxvY2ssIHRo
dXMgcGxhaW4gQyBhY2Nlc3MgaXMKKwkgKiBjb3JyZWN0LgorCSAqLwogCWlmIChzbWEtPnVz
ZV9nbG9iYWxfbG9jayA9PSAwKSB7CiAJCS8qCiAJCSAqIFRoZSB1c2VfZ2xvYmFsX2xvY2sg
bW9kZSBlbmRlZCB3aGlsZSB3ZSB3YWl0ZWQgZm9yCg==
--------------7E09A4E938C7783C55499CA3--
