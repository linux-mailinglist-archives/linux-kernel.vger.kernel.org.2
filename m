Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FC53A6F33
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbhFNTgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:36:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:19852 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235138AbhFNTgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:36:41 -0400
IronPort-SDR: sJLJS6vHOrBj8iksW0hv1PPXxuB4l+yN+wndkUFSyewUqVLZGomEtO2penzMoBffWIlcPg14Yd
 n7toOn7xbptA==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="291500757"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="291500757"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 12:34:34 -0700
IronPort-SDR: ynXsLDiELkRBmy6o8C2rIHhBfVbA7UJnfXSVUsVsMI4R4yNKxnPcN5DJhAM8pMmk9mcR8kntBV
 s6x6hF3UbxWg==
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="451695454"
Received: from sukulkar-mobl1.amr.corp.intel.com (HELO [10.212.204.222]) ([10.212.204.222])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 12:34:33 -0700
Subject: Re: [patch 09/41] x86/kvm: Avoid looking up PKRU in XSAVE buffer
To:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
References: <20210611161523.508908024@linutronix.de>
 <20210611163111.931697147@linutronix.de> <YMcuzOOCGl+nKysP@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <918268bd-8092-7511-f0b8-d981143b7610@intel.com>
Date:   Mon, 14 Jun 2021 12:34:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YMcuzOOCGl+nKysP@zn.tnic>
Content-Type: multipart/mixed;
 boundary="------------4C51F0A24FF5C92C6F645E04"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4C51F0A24FF5C92C6F645E04
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 6/14/21 3:26 AM, Borislav Petkov wrote:
> On Fri, Jun 11, 2021 at 06:15:32PM +0200, Thomas Gleixner wrote:
>> -		if (src) {
>> -			u32 size, offset, ecx, edx;
>> -			cpuid_count(XSTATE_CPUID, xfeature_nr,
>> -				    &size, &offset, &ecx, &edx);
>> -			if (xfeature_nr == XFEATURE_PKRU)
>> -				memcpy(dest + offset, &vcpu->arch.pkru,
>> -				       sizeof(vcpu->arch.pkru));
>> -			else
>> -				memcpy(dest + offset, src, size);
>> +		cpuid_count(XSTATE_CPUID, xfeature_nr,
>> +			    &size, &offset, &ecx, &edx);
>>  
>> +		if (xfeature_nr == XFEATURE_PKRU) {
>> +			memcpy(dest + offset, &vcpu->arch.pkru,
>> +			       sizeof(vcpu->arch.pkru));
>> +		} else {
>> +			src = get_xsave_addr(xsave, xfeature_nr);
>> +			if (src)
>> +				memcpy(dest + offset, src, size);
>>  		}
>>  
>>  		valid -= xfeature_mask;
> 
> How about pulling up that PKRU case even further (pasting the whole
> changed loop instead of an unreadable diff) and keeping the CPUID access
> and the xsave address handling separate?
> 
>         valid = xstate_bv & ~XFEATURE_MASK_FPSSE;
>         while (valid) {
>                 u32 size, offset, ecx, edx;
>                 u64 xfeature_mask = valid & -valid;
>                 int xfeature_nr = fls64(xfeature_mask) - 1;
>                 void *src;
> 
>                 if (xfeature_nr == XFEATURE_PKRU) {
>                         memcpy(dest + offset, &vcpu->arch.pkru, sizeof(vcpu->arch.pkru));
>                         continue;
>                 }
> 
>                 cpuid_count(XSTATE_CPUID, xfeature_nr, &size, &offset, &ecx, &edx);
> 
>                 src = get_xsave_addr(xsave, xfeature_nr);
>                 if (src)
>                         memcpy(dest + offset, src, size);
> 
>                 valid -= xfeature_mask;
>         }

I gave that a shot.  Two wrinkles: The PKRU memcpy() needs 'offset' from
cpuid_count() and the PKRU case also needs the 'valid -=' manipulation.
 The result is attached, and while it makes the diff look better, I
don't think the resulting code is an improvement.

> Btw, I'm wondering if that CPUID read in a loop can be replaced with
> adding accessors for xstate_{offsets,sizes,..} etc and providing them to
> kvm...

I *think* these are already stored in xfeature_uncompacted_offset[].  It
would be a pretty simple matter to export it.  I just assumed that this
is a slow enough path that the KVM folks don't care.

>> @@ -4632,18 +4633,20 @@ static void load_xsave(struct kvm_vcpu *
>>  	 */
>>  	valid = xstate_bv & ~XFEATURE_MASK_FPSSE;
>>  	while (valid) {
>> +		u32 size, offset, ecx, edx;
>>  		u64 xfeature_mask = valid & -valid;
>>  		int xfeature_nr = fls64(xfeature_mask) - 1;
>> -		void *dest = get_xsave_addr(xsave, xfeature_nr);
>>  
>> -		if (dest) {
>> -			u32 size, offset, ecx, edx;
>> -			cpuid_count(XSTATE_CPUID, xfeature_nr,
>> -				    &size, &offset, &ecx, &edx);
>> -			if (xfeature_nr == XFEATURE_PKRU)
>> -				memcpy(&vcpu->arch.pkru, src + offset,
>> -				       sizeof(vcpu->arch.pkru));
>> -			else
>> +		cpuid_count(XSTATE_CPUID, xfeature_nr,
>> +			    &size, &offset, &ecx, &edx);
>> +
>> +		if (xfeature_nr == XFEATURE_PKRU) {
>> +			memcpy(&vcpu->arch.pkru, src + offset,
>> +			       sizeof(vcpu->arch.pkru));
>> +		} else {
>> +			void *dest = get_xsave_addr(xsave, xfeature_nr);
>> +
> 
> 
> ^ Superfluous newline.

I'm happy to change it, but I usually like to separate declarations from
pure code.  Although, I guess that's a bit inconsistent in that file.

--------------4C51F0A24FF5C92C6F645E04
Content-Type: text/x-patch; charset=UTF-8;
 name="pkrukvm.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pkrukvm.patch"

commit a761b0a48fb62429bd98c9a1275ef3ce33f9925a
Author: Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu Jun 3 16:08:12 2021 -0700

    x86/kvm: Avoid looking up PKRU in XSAVE buffer
   =20
    PKRU is being removed from the kernel XSAVE/FPU buffers.  This remova=
l
    will probably include warnings for code that look up PKRU in those
    buffers.
   =20
    KVM currently looks up the location of PKRU but doesn't even use the
    pointer that it gets back.  Rework the code to avoid calling
    get_xsave_addr() except in cases where its result is actually used.
   =20
    This makes the code more clear and also avoids the inevitable PKRU
    warnings.
   =20
    This is probably a good cleanup and could go upstream idependently
    of any PKRU rework.
   =20
    Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
   =20
    --

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b594275d49b5..ed4c3d90a18b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4589,20 +4589,21 @@ static void fill_xsave(u8 *dest, struct kvm_vcpu =
*vcpu)
 	 */
 	valid =3D xstate_bv & ~XFEATURE_MASK_FPSSE;
 	while (valid) {
+		u32 size, offset, ecx, edx;
 		u64 xfeature_mask =3D valid & -valid;
 		int xfeature_nr =3D fls64(xfeature_mask) - 1;
-		void *src =3D get_xsave_addr(xsave, xfeature_nr);
-
-		if (src) {
-			u32 size, offset, ecx, edx;
-			cpuid_count(XSTATE_CPUID, xfeature_nr,
-				    &size, &offset, &ecx, &edx);
-			if (xfeature_nr =3D=3D XFEATURE_PKRU)
-				memcpy(dest + offset, &vcpu->arch.pkru,
-				       sizeof(vcpu->arch.pkru));
-			else
-				memcpy(dest + offset, src, size);
+		void *src;
+
+		cpuid_count(XSTATE_CPUID, xfeature_nr,
+			    &size, &offset, &ecx, &edx);
=20
+		if (xfeature_nr =3D=3D XFEATURE_PKRU) {
+			memcpy(dest + offset, &vcpu->arch.pkru,
+			       sizeof(vcpu->arch.pkru));
+		} else {
+			src =3D get_xsave_addr(xsave, xfeature_nr);
+			if (src)
+				memcpy(dest + offset, src, size);
 		}
=20
 		valid -=3D xfeature_mask;
@@ -4632,18 +4633,20 @@ static void load_xsave(struct kvm_vcpu *vcpu, u8 =
*src)
 	 */
 	valid =3D xstate_bv & ~XFEATURE_MASK_FPSSE;
 	while (valid) {
+		u32 size, offset, ecx, edx;
 		u64 xfeature_mask =3D valid & -valid;
 		int xfeature_nr =3D fls64(xfeature_mask) - 1;
-		void *dest =3D get_xsave_addr(xsave, xfeature_nr);
-
-		if (dest) {
-			u32 size, offset, ecx, edx;
-			cpuid_count(XSTATE_CPUID, xfeature_nr,
-				    &size, &offset, &ecx, &edx);
-			if (xfeature_nr =3D=3D XFEATURE_PKRU)
-				memcpy(&vcpu->arch.pkru, src + offset,
-				       sizeof(vcpu->arch.pkru));
-			else
+
+		cpuid_count(XSTATE_CPUID, xfeature_nr,
+			    &size, &offset, &ecx, &edx);
+
+		if (xfeature_nr =3D=3D XFEATURE_PKRU) {
+			memcpy(&vcpu->arch.pkru, src + offset,
+			       sizeof(vcpu->arch.pkru));
+		} else {
+			void *dest =3D get_xsave_addr(xsave, xfeature_nr);
+
+			if (dest)
 				memcpy(dest, src + offset, size);
 		}
=20

--------------4C51F0A24FF5C92C6F645E04--
