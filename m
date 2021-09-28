Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5B141B8BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 22:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242814AbhI1U5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 16:57:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:22653 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242773AbhI1U5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 16:57:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="224873050"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="224873050"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 13:55:51 -0700
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="554300891"
Received: from gpfry-mobl1.amr.corp.intel.com (HELO [10.251.22.193]) ([10.251.22.193])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 13:55:50 -0700
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <1aae375d-3cd4-4ab8-9c64-9e387916e6c0@www.fastmail.com>
 <YVIxeBh3IKYYK711@agluck-desk2.amr.corp.intel.com>
 <035290e6-d914-a113-ea6c-e845d71069cf@intel.com>
 <YVNj8sm8iectc6iU@agluck-desk2.amr.corp.intel.com>
 <3f97b77e-a609-997b-3be7-f44ff7312b0d@intel.com>
 <YVN652x14dMgyE85@agluck-desk2.amr.corp.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 xsFNBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABzShEYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gPGRhdmVAc3I3MS5uZXQ+wsF7BBMBAgAlAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAUCTo3k0QIZAQAKCRBoNZUwcMmSsMO2D/421Xg8pimb9mPzM5N7khT0
 2MCnaGssU1T59YPE25kYdx2HntwdO0JA27Wn9xx5zYijOe6B21ufrvsyv42auCO85+oFJWfE
 K2R/IpLle09GDx5tcEmMAHX6KSxpHmGuJmUPibHVbfep2aCh9lKaDqQR07gXXWK5/yU1Dx0r
 VVFRaHTasp9fZ9AmY4K9/BSA3VkQ8v3OrxNty3OdsrmTTzO91YszpdbjjEFZK53zXy6tUD2d
 e1i0kBBS6NLAAsqEtneplz88T/v7MpLmpY30N9gQU3QyRC50jJ7LU9RazMjUQY1WohVsR56d
 ORqFxS8ChhyJs7BI34vQusYHDTp6PnZHUppb9WIzjeWlC7Jc8lSBDlEWodmqQQgp5+6AfhTD
 kDv1a+W5+ncq+Uo63WHRiCPuyt4di4/0zo28RVcjtzlGBZtmz2EIC3vUfmoZbO/Gn6EKbYAn
 rzz3iU/JWV8DwQ+sZSGu0HmvYMt6t5SmqWQo/hyHtA7uF5Wxtu1lCgolSQw4t49ZuOyOnQi5
 f8R3nE7lpVCSF1TT+h8kMvFPv3VG7KunyjHr3sEptYxQs4VRxqeirSuyBv1TyxT+LdTm6j4a
 mulOWf+YtFRAgIYyyN5YOepDEBv4LUM8Tz98lZiNMlFyRMNrsLV6Pv6SxhrMxbT6TNVS5D+6
 UorTLotDZKp5+M7BTQRUY85qARAAsgMW71BIXRgxjYNCYQ3Xs8k3TfAvQRbHccky50h99TUY
 sqdULbsb3KhmY29raw1bgmyM0a4DGS1YKN7qazCDsdQlxIJp9t2YYdBKXVRzPCCsfWe1dK/q
 66UVhRPP8EGZ4CmFYuPTxqGY+dGRInxCeap/xzbKdvmPm01Iw3YFjAE4PQ4hTMr/H76KoDbD
 cq62U50oKC83ca/PRRh2QqEqACvIH4BR7jueAZSPEDnzwxvVgzyeuhwqHY05QRK/wsKuhq7s
 UuYtmN92Fasbxbw2tbVLZfoidklikvZAmotg0dwcFTjSRGEg0Gr3p/xBzJWNavFZZ95Rj7Et
 db0lCt0HDSY5q4GMR+SrFbH+jzUY/ZqfGdZCBqo0cdPPp58krVgtIGR+ja2Mkva6ah94/oQN
 lnCOw3udS+Eb/aRcM6detZr7XOngvxsWolBrhwTQFT9D2NH6ryAuvKd6yyAFt3/e7r+HHtkU
 kOy27D7IpjngqP+b4EumELI/NxPgIqT69PQmo9IZaI/oRaKorYnDaZrMXViqDrFdD37XELwQ
 gmLoSm2VfbOYY7fap/AhPOgOYOSqg3/Nxcapv71yoBzRRxOc4FxmZ65mn+q3rEM27yRztBW9
 AnCKIc66T2i92HqXCw6AgoBJRjBkI3QnEkPgohQkZdAb8o9WGVKpfmZKbYBo4pEAEQEAAcLB
 XwQYAQIACQUCVGPOagIbDAAKCRBoNZUwcMmSsJeCEACCh7P/aaOLKWQxcnw47p4phIVR6pVL
 e4IEdR7Jf7ZL00s3vKSNT+nRqdl1ugJx9Ymsp8kXKMk9GSfmZpuMQB9c6io1qZc6nW/3TtvK
 pNGz7KPPtaDzvKA4S5tfrWPnDr7n15AU5vsIZvgMjU42gkbemkjJwP0B1RkifIK60yQqAAlT
 YZ14P0dIPdIPIlfEPiAWcg5BtLQU4Wg3cNQdpWrCJ1E3m/RIlXy/2Y3YOVVohfSy+4kvvYU3
 lXUdPb04UPw4VWwjcVZPg7cgR7Izion61bGHqVqURgSALt2yvHl7cr68NYoFkzbNsGsye9ft
 M9ozM23JSgMkRylPSXTeh5JIK9pz2+etco3AfLCKtaRVysjvpysukmWMTrx8QnI5Nn5MOlJj
 1Ov4/50JY9pXzgIDVSrgy6LYSMc4vKZ3QfCY7ipLRORyalFDF3j5AGCMRENJjHPD6O7bl3Xo
 4DzMID+8eucbXxKiNEbs21IqBZbbKdY1GkcEGTE7AnkA3Y6YB7I/j9mQ3hCgm5muJuhM/2Fr
 OPsw5tV/LmQ5GXH0JQ/TZXWygyRFyyI2FqNTx4WHqUn3yFj8rwTAU1tluRUYyeLy0ayUlKBH
 ybj0N71vWO936MqP6haFERzuPAIpxj2ezwu0xb1GjTk4ynna6h5GjnKgdfOWoRtoWndMZxbA
 z5cecg==
Message-ID: <f6014b16-7b4c-cbb6-c975-1ec34092956f@intel.com>
Date:   Tue, 28 Sep 2021 13:55:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YVN652x14dMgyE85@agluck-desk2.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/21 1:28 PM, Luck, Tony wrote:
> On Tue, Sep 28, 2021 at 12:19:22PM -0700, Dave Hansen wrote:
>> On 9/28/21 11:50 AM, Luck, Tony wrote:
>>> On Mon, Sep 27, 2021 at 04:51:25PM -0700, Dave Hansen wrote:
>> ...
>>>> 1. Hide whether we need to write to real registers
>>>> 2. Hide whether we need to update the in-memory image
>>>> 3. Hide other FPU infrastructure like the TIF flag.
>>>> 4. Make the users deal with a *whole* state in the replace API
>>>
>>> Is that difference just whether you need to save the
>>> state from registers to memory (for the "update" case)
>>> or not (for the "replace" case ... where you can ignore
>>> the current register, overwrite the whole per-feature
>>> xsave area and mark it to be restored to registers).
>>>
>>> If so, just a "bool full" argument might do the trick?
>>
>> I want to be able to hide the complexity of where the old state comes
>> from.  It might be in registers or it might be in memory or it might be
>> *neither*.  It's possible we're running with stale register state and a
>> current->...->xsave buffer that has XFEATURES&XFEATURE_FOO 0.
>>
>> In that case, the "old" copy might be memcpy'd out of the init_task.
>> Or, for pkeys, we might build it ourselves with init_pkru_val.
> 
> So should there be an error case if there isn't an "old" state, and
> the user calls:
> 
> 	p = begin_update_one_xsave_feature(XFEATURE_something, false);
> 
> Maybe instead of an error, just fill it in with the init state for the feature?

Yes, please.  Let's not generate an error.  Let's populate the init
state and let them move on with life.

>>> pseudo-code:
>>>
>>> void *begin_update_one_xsave_feature(enum xfeature xfeature, bool full)
>>> {
>>> 	void *addr;
>>>
>>> 	BUG_ON(!(xsave->header.xcomp_bv & xfeature));
>>>
>>> 	addr = __raw_xsave_addr(xsave, xfeature);
>>>
>>> 	fpregs_lock();
>>>
>>> 	if (full)
>>> 		return addr;
>>
>> If the feature is marked as in the init state in the buffer
>> (XSTATE_BV[feature]==0), this addr *could* contain total garbage.  So,
>> we'd want to make sure that the memory contents have the init state
>> written before handing them back to the caller.  That's not strictly
>> required if the user is writing the whole thing, but it's the nice thing
>> to do.
> 
> Nice guys waste CPU cycles writing to memory that is just going to get
> written again.

Let's skip the "replace" operation for now and focus on "update".  A
full replace *can* be faster because it doesn't require the state to be
written out.  But, we don't need that for now.

Let's just do the "update" thing, and let's ensure that we reflect the
init state into the buffer that gets returned if the feature was in its
init state.

Sound good?

>>> 	if (xfeature registers are "live")
>>> 		xsaves(xstate, 1 << xfeature);
>>
>> One little note: I don't think we would necessarily need to do an XSAVES
>> here.  For PKRU, for instance, we could just do a rdpkru.
> 
> Like this?
> 
> 	if (tsk == current) {
> 		switch (xfeature) {
> 		case XFEATURE_PKRU:
> 			*(u32 *)addr = rdpkru();
> 			break;
> 		case XFEATURE_PASID:
> 			rdmsrl(MSR_IA32_PASID, msr);
> 			*(u64 *)addr = msr;
> 			break;
> 		... any other "easy" states ...
> 		default:
> 			xsaves(xstate, 1 << xfeature);
> 			break;
> 		}
> 	}

Yep.

>>> 	return addr;
>>> }
>>>
>>> void finish_update_one_xsave_feature(enum xfeature xfeature)
>>> {
>>> 	mark feature modified
>>
>> I think we'd want to do this at the "begin" time.  Also, do you mean we
>> should set XSTATE_BV[feature]?
> 
> Begin? End? It's all inside fpregs_lock(). But whatever seems best.

I'm actually waffling about it.

Does XSTATE_BV[feature] mean that state *is* there or that state *may*
be there?  Either way works.

>> It's also worth noting that we *could*:
>>
>> 	xrstors(xstate, 1<<xfeature);
>>
>> as well.  That would bring the registers back up to day and we could
>> keep TIF_NEED_FPU_LOAD==0.
> 
> Only makes sense if "tsk == current". But does this help. The work seems
> to be the same whether we do it now, or later. We don't know for sure
> that we will directly return to the task. We might context switch to
> another task, so loading the state into registers now would just be
> wasted time.

True, but the other side of the coin is that setting TIF_NEED_FPU_LOAD
subjects us to an XRSTOR on the way out to userspace.  That XRSTOR might
just be updating one state component in practice.

Either way, sorry for the distraction.  We (me) should really be
focusing on getting something that is functional but slow.
