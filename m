Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EE8416C98
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 09:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244340AbhIXHO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 03:14:28 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:40441 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244191AbhIXHO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 03:14:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UpPgYjK_1632467570;
Received: from 30.240.96.158(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UpPgYjK_1632467570)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 24 Sep 2021 15:12:51 +0800
Content-Type: multipart/mixed; boundary="------------dSyY0MTrLfA4xeR62xlxCVge"
Message-ID: <9e41661d-9919-d556-8c49-610dae157553@linux.alibaba.com>
Date:   Fri, 24 Sep 2021 15:12:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:93.0)
 Gecko/20100101 Thunderbird/93.0
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page
 cache
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        song@kernel.org, william.kucharski@oracle.com,
        Hugh Dickins <hughd@google.com>
References: <20210906121200.57905-1-rongwei.wang@linux.alibaba.com>
 <20210922070645.47345-2-rongwei.wang@linux.alibaba.com>
 <YUsVcEDcQ2vEzjGg@casper.infradead.org>
 <BC145393-93AC-4DF4-9CF4-2FB1C736B70C@linux.alibaba.com>
 <20210923194343.ca0f29e1c4d361170343a6f2@linux-foundation.org>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <20210923194343.ca0f29e1c4d361170343a6f2@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------dSyY0MTrLfA4xeR62xlxCVge
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/24/21 10:43 AM, Andrew Morton wrote:
> On Thu, 23 Sep 2021 01:04:54 +0800 Rongwei Wang <rongwei.wang@linux.alibaba.com> wrote:
> 
>>
>>
>>> On Sep 22, 2021, at 7:37 PM, Matthew Wilcox <willy@infradead.org> wrote:
>>>
>>> On Wed, Sep 22, 2021 at 03:06:44PM +0800, Rongwei Wang wrote:
>>>> Transparent huge page has supported read-only non-shmem files. The file-
>>>> backed THP is collapsed by khugepaged and truncated when written (for
>>>> shared libraries).
>>>>
>>>> However, there is race in two possible places.
>>>>
>>>> 1) multiple writers truncate the same page cache concurrently;
>>>> 2) collapse_file rolls back when writer truncates the page cache;
>>>
>>> As I've said before, the bug here is that somehow there is a writable fd
>>> to a file with THPs.  That's what we need to track down and fix.
>> Hi, Matthew
>> I am not sure get your means. We know “mm, thp: relax the VM_DENYWRITE constraint on file-backed THPs"
>> Introduced file-backed THPs for DSO. It is possible {very rarely} for DSO to be opened in writeable way.
>>
>> ...
>>
>>> https://lore.kernel.org/linux-mm/YUdL3lFLFHzC80Wt@casper.infradead.org/
>> All in all, what you mean is that we should solve this race at the source?
> 
> Matthew is being pretty clear here: we shouldn't be permitting
> userspace to get a writeable fd for a thp-backed file.
> 
> Why are we permitting the DSO to be opened writeably?  If there's a
> legitimate case for doing this then presumably "mm, thp: relax the
There is a use case to stress file-backed THP within attachment.
I test this case in a system which has enabled CONFIG_READ_ONLY_THP_FOR_FS:

$ gcc -Wall -g -o stress_madvise_dso stress_madvise_dso.c
$ ulimit -s unlimited
$ ./stress_madvise_dso 10000 <libtest.so>

the meaning of above parameters:
10000: the max test time;
<libtest.so>: the DSO that will been mapped into file-backed THP by 
madvise. It recommended that the text segment of DSO to be tested is 
greater than 2M.

The crash will been triggered at once in the latest kernel. And this
case also can used to trigger the bug that mentioned in our another patch.

> VM_DENYWRITE constraint on file-backed THPs: should be fixed or
> reverted.
> 
> If there is no legitimate use case for returning a writeable fd for a
> thp-backed file then we should fail such an attempt at open().  This
> approach has back-compatibility issues which need to be thought about.
> Perhaps we should permit the open-writeably attempt to appear to
> succeed, but to really return a read-only fd?
> 
--------------dSyY0MTrLfA4xeR62xlxCVge
Content-Type: text/plain; charset=UTF-8; name="stress_madvise_dso.c"
Content-Disposition: attachment; filename="stress_madvise_dso.c"
Content-Transfer-Encoding: base64

LyoKICogY2FzZTogc3RyZXNzIGZpbGUtYmFja2VkIFRIUAogKi8KI2lmbmRlZiBfR05VX1NP
VVJDRQojZGVmaW5lIF9HTlVfU09VUkNFCiNlbmRpZgoKI2luY2x1ZGUgPGFzc2VydC5oPgoj
aW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIu
aD4KI2luY2x1ZGUgPHN0ZGludC5oPgojaW5jbHVkZSA8c2NoZWQuaD4KI2luY2x1ZGUgPHRp
bWUuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUg
PHNpZ25hbC5oPiAvKiBmb3Igc2lnbmFsICovCiNpbmNsdWRlIDxzeXMvbW1hbi5oPgojaW5j
bHVkZSA8c3lzL3RpbWUuaD4KI2luY2x1ZGUgPHN5cy90eXBlcy5oPgojaW5jbHVkZSA8c3lz
L3dhaXQuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8ZXJybm8uaD4KCiNkZWZp
bmUgUEFUSF9NQVgJMTAyNAojZGVmaW5lIEJVRkZfTUFYCTEwMjQKI2RlZmluZSBUSU1FX0RG
TAkxODAJLyogc2Vjb25kcyAqLwoKdm9pZCBzaWduYWxfaGFuZGxlcihpbnQgc2lnbm8pCnsK
CS8qIFJlc3RvcmUgZW52ICovCglzeXN0ZW0oImVjaG8gbmV2ZXIgPiAvc3lzL2tlcm5lbC9t
bS90cmFuc3BhcmVudF9odWdlcGFnZS9lbmFibGVkIik7CglzeXN0ZW0oImVjaG8gMTAwMDAg
PiAvc3lzL2tlcm5lbC9tbS90cmFuc3BhcmVudF9odWdlcGFnZS9raHVnZXBhZ2VkL3NjYW5f
c2xlZXBfbWlsbGlzZWNzIik7CgoJcHJpbnRmKCJcbnJlc3RvcmUgZW52OlxuIik7Cglwcmlu
dGYoIgllY2hvIG5ldmVyID4gL3N5cy9rZXJuZWwvbW0vdHJhbnNwYXJlbnRfaHVnZXBhZ2Uv
ZW5hYmxlZFxuIik7CglwcmludGYoIgllY2hvIDEwMDAwID4gL3N5cy9rZXJuZWwvbW0vdHJh
bnNwYXJlbnRfaHVnZXBhZ2Uva2h1Z2VwYWdlZC9zY2FuX3NsZWVwX21pbGxpc2Vjc1xuIik7
CglleGl0KC0xKTsKfQoKLyogaW4gS0IgKi8KI2RlZmluZSB0ZXh0X3NpemUJKDE0VUwgPDwg
MTApCgojZGVmaW5lIFBST0NNQVBfU1oJOApzdHJ1Y3QgcHJvY21hcCB7Cgl1aW50NjRfdCB2
bV9zdGFydDsKCXVpbnQ2NF90IHZtX2VuZDsKCXVpbnQ2NF90IHBnb2ZmOwoJdWludDMyX3Qg
bWFqOwoJdWludDMyX3QgbWluOwoJdWludDMyX3QgaW5vOwojZGVmaW5lIFBST1RfU1oJCTUK
CWNoYXIgICAgIHByb3RbUFJPVF9TWl07CgljaGFyICAgICBmbmFtZVtQQVRIX01BWF07Cn07
Cgp1bnNpZ25lZCBsb25nIHNsZWVwX3NlY3MgPSAwOwoKLyoKICogUm91dGluZXMgb2YgcHJv
Y21hcCwgaS5lLiwgL3Byb2MvcGlkLyhzKW1hcHMKICovCnN0YXRpYyBpbnQgZ2V0X21lbW9y
eV9tYXAocGlkX3QgcGlkLCBzdHJ1Y3QgcHJvY21hcCAqcHJvY21hcCwKCQljb25zdCBjaGFy
ICpmbmFtZSkKewoJY2hhciBwYXRoW1BBVEhfTUFYXTsKCWNoYXIgbGluZVtCVUZGX01BWF07
CglGSUxFICpmcCA9IE5VTEw7CgljaGFyICplbmQgPSBOVUxMOwoJY2hhciAqcG9zLCAqc3Ag
PSBOVUxMLCAqaW5bUFJPQ01BUF9TWl07CgljaGFyIGRsbVtdID0gIi0gICA6ICAgIjsKCXVp
bnQ2NF90IGNvdW50ZXI7CglpbnQgaTsKCglzbnByaW50ZihwYXRoLCBQQVRIX01BWCwgIi9w
cm9jLyV1L21hcHMiLCBwaWQpOwoKCWZwID0gZm9wZW4ocGF0aCwgInIiKTsKCWlmIChmcCA9
PSBOVUxMKSB7CgkJcHJpbnRmKCJmb3BlbjogJXM6ICVzXG4iLCBwYXRoLCBzdHJlcnJvcihl
cnJubykpOwoJCXJldHVybiAtMTsKCX0KCglpZiAocHJvY21hcCA9PSBOVUxMIHx8IGZuYW1l
ID09IE5VTEwpIHsKCQlwZXJyb3IoImZhaWw6IHByb2NtYXAgb3IgZm5hbWUgaXMgTlVMTCIp
OwoJCWdvdG8gZmFpbGVkOwoJfQoKCXdoaWxlIChmZ2V0cyhsaW5lLCBCVUZGX01BWCwgZnAp
KSB7CgkJLyogU3BsaXQgbGluZSBpbnRvIGZpZWxkcyAqLwoJCXBvcyA9IGxpbmU7CgkJZm9y
IChpID0gMDsgaSA8IFBST0NNQVBfU1o7IGkrKykgewoJCQlpbltpXSA9IHN0cnRva19yKHBv
cywgJmRsbVtpXSwgJnNwKTsKCQkJaWYgKGluW2ldID09IE5VTEwpCgkJCQlicmVhazsKCQkJ
cG9zID0gTlVMTDsKCQl9CgoJCS8qIENoZWNrIHRoaXMgbGluZSBpcyBwcm9jbWFwIGl0ZW0g
aGVhZGVyICovCgkJaWYgKGkgIT0gUFJPQ01BUF9TWikKCQkJY29udGludWU7CgoJCW1lbWNw
eShwcm9jbWFwLT5wcm90LCBpblsyXSwgUFJPVF9TWik7CgkJbWVtY3B5KHByb2NtYXAtPmZu
YW1lLCBpbls3XSwgUEFUSF9NQVgpOwoKCQkvKiBGaW5kIHRoZSB0YXJnZXQgZW50cnkgKi8K
CQlpZiAoc3RyY21wKHByb2NtYXAtPnByb3QsICJyLXhwIikgfHwKCQkJCSFzdHJzdHIocHJv
Y21hcC0+Zm5hbWUsIGZuYW1lKSkKCQkJY29udGludWU7CgoJCS8qIENvbnZlcnQvQ29weSBl
YWNoIGZpZWxkIGFzIG5lZWRlZCAqLwoJCWVycm5vID0gMDsKCQlwcm9jbWFwLT52bV9zdGFy
dCA9IHN0cnRvdWxsKGluWzBdLCAmZW5kLCAxNik7CgkJaWYgKChpblswXSA9PSAnXDAnKSB8
fCAoZW5kID09IE5VTEwpIHx8ICgqZW5kICE9ICdcMCcpIHx8CgkJCQkoZXJybm8gIT0gMCkp
CgkJCWdvdG8gZmFpbGVkOwoKCQlwcm9jbWFwLT52bV9lbmQgPSBzdHJ0b3VsbChpblsxXSwg
JmVuZCwgMTYpOwoJCWlmICgoaW5bMV0gPT0gJ1wwJykgfHwgKGVuZCA9PSBOVUxMKSB8fCAo
KmVuZCAhPSAnXDAnKSB8fAoJCQkJKGVycm5vICE9IDApKQoJCQlnb3RvIGZhaWxlZDsKCgkJ
cHJvY21hcC0+cGdvZmYgPSBzdHJ0b3VsbChpblszXSwgJmVuZCwgMTYpOwoJCWlmICgoaW5b
M10gPT0gJ1wwJykgfHwgKGVuZCA9PSBOVUxMKSB8fCAoKmVuZCAhPSAnXDAnKSB8fAoJCQkJ
KGVycm5vICE9IDApKQoJCQlnb3RvIGZhaWxlZDsKCgkJcHJvY21hcC0+aW5vID0gc3RydG91
bChpbls2XSwgJmVuZCwgMTYpOwoJCWlmICgoaW5bNl0gPT0gJ1wwJykgfHwgKGVuZCA9PSBO
VUxMKSB8fCAoKmVuZCAhPSAnXDAnKSB8fAoJCQkJKGVycm5vICE9IDApKQoJCQlnb3RvIGZh
aWxlZDsKCX0KCglpZiAoZnApCgkJZmNsb3NlKGZwKTsKCXJldHVybiAwOwoKZmFpbGVkOgoJ
aWYgKGZwKQoJCWZjbG9zZShmcCk7CglwcmludGYoImZhaWw6IGV4aXRcbiIpOwoKCXJldHVy
biAtMTsKfQoKI2RlZmluZSBOUl9DUFUgMzIKdWludDY0X3QgZ2V0dGltZW9mZGF5X3NlYyh2
b2lkKTsKaW5saW5lIHVpbnQ2NF90IGdldHRpbWVvZmRheV9zZWModm9pZCkKewoJc3RydWN0
IHRpbWV2YWwgdHY7CgoJZ2V0dGltZW9mZGF5KCZ0diwgTlVMTCk7CglyZXR1cm4gdHYudHZf
c2VjOwp9Cgp2b2lkIHRocmVhZF9yZWFkKGludCBjcHUsIGNoYXIgKmFyZ3MpCnsKCWludCBm
ZDsKCWNoYXIgKmRzb19wYXRoID0gYXJnczsKCWNoYXIgYnVmWzB4ODAwMDAwXTsKCXN0cnVj
dCBwcm9jbWFwIG1hcHM7CglwaWRfdCBwaWQgPSBnZXRwaWQoKTsKCgljcHVfc2V0X3QgbWFz
azsKCUNQVV9aRVJPKCZtYXNrKTsKCUNQVV9TRVQoY3B1LCAmbWFzayk7CglpZiAoc2NoZWRf
c2V0YWZmaW5pdHkoMCwgc2l6ZW9mKGNwdV9zZXRfdCksICZtYXNrKSA9PSAtMSkgewoJCXBy
aW50Zigid2FybmluZzogY2FuIG5vdCBzZXQgQ1BVIGFmZmluaXR5XG4iKTsKCX0KCglwcmlu
dGYoInJlYWQgJXNcbiIsIGRzb19wYXRoKTsKCWZkID0gb3Blbihkc29fcGF0aCwgT19SRE9O
TFkpOwoJLyogVGhlIHN0YXJ0IGFkZHIgbXVzdCBiZSBhbGlnbm1lbnQgd2l0aCAyTSAqLwoJ
dm9pZCAqcCA9IG1tYXAoKHZvaWQgKikweDQwMDAwZGMwMDAwMFVMLCAweDgwMDAwMCwgUFJP
VF9SRUFEIHwgUFJPVF9FWEVDLAoJCQlNQVBfUFJJVkFURSwgZmQsIDApOwoJaWYgKHAgPT0g
TUFQX0ZBSUxFRCkgewoJCXBlcnJvcigibW1hcCIpOwoJCWdvdG8gb3V0OwoJfQoKCS8qIGdl
dCB0aGUgbWFwcGluZyBhZGRyZXNzIChPTkxZIHIteHApIG9mIHRoZSBEU08gKi8KCWdldF9t
ZW1vcnlfbWFwKHBpZCwgJm1hcHMsIGRzb19wYXRoKTsKCXByaW50ZigicGlkOiAlZFxuIiwg
cGlkKTsKCXByaW50ZigidGV4dCB2bV9zdGFydDogMHglbHhcbiIsIG1hcHMudm1fc3RhcnQp
OwoJcHJpbnRmKCJ0ZXh0IHZtX2VuZDogMHglbHhcbiIsIG1hcHMudm1fZW5kKTsKCW1hZHZp
c2UoKHZvaWQgKiltYXBzLnZtX3N0YXJ0LCBtYXBzLnZtX2VuZCAtIG1hcHMudm1fc3RhcnQs
IE1BRFZfSFVHRVBBR0UpOwoJbHNlZWsoZmQsIDAsIFNFRUtfU0VUKTsKCWZvcig7OykgewoJ
CW1lbWNweShidWYsIHAsIDB4ODAwMDAwIC0gMSk7CgkJc2xlZXAoMSk7Cgl9CgoJc2xlZXAo
MTAwKTsKCm91dDoKCS8qIFJlc3RvcmUgZW52ICovCglzeXN0ZW0oImVjaG8gbmV2ZXIgPiAv
c3lzL2tlcm5lbC9tbS90cmFuc3BhcmVudF9odWdlcGFnZS9lbmFibGVkIik7CglzeXN0ZW0o
ImVjaG8gMTAwMDAgPiAvc3lzL2tlcm5lbC9tbS90cmFuc3BhcmVudF9odWdlcGFnZS9raHVn
ZXBhZ2VkL3NjYW5fc2xlZXBfbWlsbGlzZWNzIik7CgoJcHJpbnRmKCJyZWFkIGV4aXQgJXNc
biIsIGRzb19wYXRoKTsKfQoKdm9pZCB0aHJlYWRfd3JpdGUoaW50IGNwdSwgY2hhciAqYXJn
cykKewoJdm9pZCAqcCA9IE5VTEw7CgljaGFyIGJ1ZlszMl07Cgl1aW50NjRfdCBzZWMgPSAx
OwoJdWludDY0X3QgY291bnQgPSAwOwoJY2hhciAqZHNvX3BhdGggPSBhcmdzOwoKCWNwdV9z
ZXRfdCBtYXNrOwoJQ1BVX1pFUk8oJm1hc2spOwoJQ1BVX1NFVChjcHUsICZtYXNrKTsKCWlm
IChzY2hlZF9zZXRhZmZpbml0eSgwLCBzaXplb2YoY3B1X3NldF90KSwgJm1hc2spID09IC0x
KSB7CgkJcHJpbnRmKCJ3YXJuaW5nOiBjYW4gbm90IHNldCBDUFUgYWZmaW5pdHlcbiIpOwoJ
fQoKCXNsZWVwKDMpOwoJcHJpbnRmKCJ3cml0ZSAlc1xuIiwgZHNvX3BhdGgpOwoJZm9yICg7
OykgewoJCXNlYyA9IGdldHRpbWVvZmRheV9zZWMoKTsKCQl3aGlsZSAoKHNlYyAlIDEwKSA+
PSAzKSB7CgkJCXNlYyA9IGdldHRpbWVvZmRheV9zZWMoKTsKCQl9CgoJCWludCBmZCA9IG9w
ZW4oZHNvX3BhdGgsIE9fUkRXUik7CgkJcCA9IG1tYXAoTlVMTCwgMHg4MDAwMDAsIFBST1Rf
UkVBRCB8IFBST1RfV1JJVEUsIE1BUF9TSEFSRUQsIGZkLCAwKTsKCQlpZiAocCA9PSBNQVBf
RkFJTEVEKSB7CgkJCXBlcnJvcigibW1hcCIpOwoJCQlnb3RvIG91dDsgLyogZmFpbCAqLwoJ
CX0KCgkJbHNlZWsoZmQsIDB4MTYwMCwgU0VFS19TRVQpOwoJCWZvcihsb25nIGk9MTsgaSA8
PSAyOyBpKyspewoJCQltZW1jcHkocCArIDB4MTAsIGJ1ZiwgMTYpOwoJCX0KCgkJbXVubWFw
KHAsIDB4ODAwMDAwKTsKCQljbG9zZShmZCk7CgoJCXNsZWVwKDIpOwoJCWNvdW50Kys7CgkJ
aWYgKGNvdW50ID49IHNsZWVwX3NlY3MpIHsKCQkJcHJpbnRmKCJ0ZXN0IGZpbmlzaDogJWxk
XG4iLCBjb3VudCk7CgkJCWJyZWFrOwoJCX0KCX0gLyogZW5kIGZvciAqLwoKb3V0OgoJcHJp
bnRmKCJ3cml0ZSBleGl0ICVzXG4iLCBkc29fcGF0aCk7Cn0KCi8qCiAqIHVzYWdlOgogKgkJ
c3RyZXNzX21hZHZpc2VfZHNvIDx0ZXN0IHRpbWU+IDxsaWJ0ZXN0LnNvPgogKi8KaW50IG1h
aW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKewoJc3RydWN0IHRpbWV2YWwgc3RhcnQsIGVu
ZDsKCWNoYXIgZHNvX3BhdGhbODBdOwoJaW50IHJldCA9IDA7CglwaWRfdCBwaWQ7CgoJaWYg
KGFyZ2MgPiAyKSB7CgkJc2xlZXBfc2VjcyA9IHN0cnRvdWwoYXJndlsxXSwgTlVMTCwgMTAp
OwoJCXJlYWxwYXRoKGFyZ3ZbMl0sIGRzb19wYXRoKTsKCX0KCWVsc2UgewoJCXByaW50Zigi
dXNhZ2UgZXJyb3I6XG4iXAoJCQkJIglzdHJlc3NfbWFkdmlzZV9kc28gPHRlc3QgdGltZT4g
PGxpYnRlc3Quc28+XG4iXAoJCQkJIgllLmcuIHN0cmVzc19tYWR2aXNlX2RzbyAxMDAwMCBs
aWJ0ZXN0LnNvXG4iKTsKCQlleGl0KC0xKTsKCX0KCgkvKiBTZXQgZW52ICovCglzeXN0ZW0o
InVsaW1pdCAtcyB1bmxpbWl0ZWQiKTsKCXN5c3RlbSgiZWNobyBtYWR2aXNlID4gL3N5cy9r
ZXJuZWwvbW0vdHJhbnNwYXJlbnRfaHVnZXBhZ2UvZW5hYmxlZCIpOwoJc3lzdGVtKCJlY2hv
IDEwMDAgPiAvc3lzL2tlcm5lbC9tbS90cmFuc3BhcmVudF9odWdlcGFnZS9raHVnZXBhZ2Vk
L3NjYW5fc2xlZXBfbWlsbGlzZWNzIik7CgoJZ2V0dGltZW9mZGF5KCZzdGFydCwgTlVMTCk7
CgoJLyoKCSAqIGZvcmsgMzIgdGFzayB0byByZWFkIGFuZCB3cml0ZSB0aGUgc2FtZSBEU086
CgkgKgkJdGFzayAwOiByZWFkIGRzbzsKCSAqCQl0YXNrIDEgLSAzMTogd3JpdGUgZHNvOwoJ
ICovCglmb3IgKGludCBpID0gMDsgaSA8IE5SX0NQVTsgKytpKSB7CgkJcGlkID0gZm9yaygp
OwoJCWlmIChwaWQgPT0gMCkgewoJCQlpZiAoaSA9PSAwKQoJCQkJdGhyZWFkX3JlYWQoaSwg
ZHNvX3BhdGgpOwoJCQllbHNlCgkJCQl0aHJlYWRfd3JpdGUoaSwgZHNvX3BhdGgpOwoJCQli
cmVhazsgLyogZm9yYmlkIGNoaWxkIGZvcmsgKi8KCQl9CgkJZWxzZSB7CgkJCS8qIHBhcmVu
dCAqLwoJCX0KCX0KCglpZiAocGlkICE9IDApIHsKCQlzaWduYWwoU0lHSU5ULCBzaWduYWxf
aGFuZGxlcik7CgkJc2lnbmFsKFNJR1NFR1YsIHNpZ25hbF9oYW5kbGVyKTsKCQlzaWduYWwo
U0lHQUJSVCwgc2lnbmFsX2hhbmRsZXIpOwoJCS8qIHdhaXQgKi8KCQl3aGlsZSAoMSkgewoJ
CQlpbnQgc3RhdHVzOwoKCQkJcGlkX3QgZG9uZSA9IHdhaXQoJnN0YXR1cyk7CgkJCWlmIChk
b25lID09IC0xKSB7CgkJCQlpZiAoZXJybm8gPT0gRUNISUxEKQoJCQkJCWJyZWFrOyAvKiBO
byBtb3JlIGNoaWxkIHByb2Nlc3NlcyAqLwoJCQl9IGVsc2UgewoJCQkJaWYgKCFXSUZFWElU
RUQoc3RhdHVzKSB8fCBXRVhJVFNUQVRVUyhzdGF0dXMpICE9IDApIHsKCQkJCQlwcmludGYo
IlBpZDolZCBmYWlsZWRcbiIsIGRvbmUpOwoJCQkJCWdvdG8gb3V0OwoJCQkJfQoJCQl9CgkJ
fQoJfQoKb3V0OgoJaWYgKHJldCA9PSAwKSB7CgkJZ2V0dGltZW9mZGF5KCZlbmQsIE5VTEwp
OwoJCXByaW50ZigidGltZSB0byBjb2xsYXBzZSBmaWxlIHRocDogJWxkIG1zXG4iLAoJCQkJ
MTAwMCAqIChlbmQudHZfc2VjIC0gc3RhcnQudHZfc2VjKSArCgkJCQkoZW5kLnR2X3VzZWMg
LSBzdGFydC50dl91c2VjKSAvIDEwMDApOwoJfQoKCXJldHVybiByZXQ7Cn0K
--------------dSyY0MTrLfA4xeR62xlxCVge--

