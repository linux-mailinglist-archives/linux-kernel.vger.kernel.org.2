Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7093945AC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 18:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbhE1QM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 12:12:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:28925 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230080AbhE1QMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 12:12:54 -0400
IronPort-SDR: L7zM+CnPzaRBBDrofXwqIO9ItP8Zq/Pk3ZVqL8gX2sNKaG1cOV+Znv7ci32I/vpVXYmZFwXGbB
 MTugXQ82xQpQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9998"; a="199947283"
X-IronPort-AV: E=Sophos;i="5.83,229,1616482800"; 
   d="scan'208";a="199947283"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2021 09:11:13 -0700
IronPort-SDR: e8KvsMpmDZjSD/lFiNeJWB/Ni7hMUdZfJvZEY7T6TVQ1XrCR7eUi1NgNqMgHLcPn6+EAp9Y2Q2
 KWjOp2LyQKWA==
X-IronPort-AV: E=Sophos;i="5.83,229,1616482800"; 
   d="scan'208";a="481095571"
Received: from yihleong-mobl.amr.corp.intel.com (HELO [10.255.228.69]) ([10.255.228.69])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2021 09:11:12 -0700
Subject: Re: [PATCH 0/5] x86/pkeys: PKRU manipulation bug fixes and cleanups
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de,
        x86@kernel.org, luto@kernel.org, shuah@kernel.org,
        babu.moger@amd.com, dave.kleikamp@oracle.com, linuxram@us.ibm.com,
        bauerman@linux.ibm.com
References: <20210527235109.B2A9F45F@viggo.jf.intel.com>
 <87eedq7u2b.ffs@nanos.tec.linutronix.de>
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
Message-ID: <4c3bfc27-a542-8e91-7ccf-4be8b1e6c844@intel.com>
Date:   Fri, 28 May 2021 09:11:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87eedq7u2b.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/21 8:32 AM, Thomas Gleixner wrote:
>>
>> This series:
>>  * Moves the PKRU manipulation to a more appropriate location,
>>    away from the page table code
>>  * Wraps get_xsave_addr() with more structured, less error-prone
>>    interfaces.
>>  * Conditionally hides a pkey debugfs file, eliminating the need
>>    for new runtime checks to work with the new interface.
>>  * Add a selftest to make it more likely to catch bugs like this
>>    in the future.  This improved selftest catches this issue on
>>    Intel CPUs.  Without the improvement, it only triggers on AMD.
> I think all of this is fundamentaly wrong.
> 
> Contrary to FPU state, PKRU has to be updated at context switch
> time. There is absolutely no point in having PKRU XSAVES managed.
> 
> It's broken in several ways. Anything which clears and loads the FPU
> will load the wrong PKRU value. Go figure...
> 
> So the right thing is to disable PKRU in XCR0 and on sched out simply do
> 
>    task->thread.pkru = read_pkru();
> 
> and on sched in
> 
>    write_pkru(task->thread.pkru);
> 
> Simple, trivial and not going to be wreckaged by anything which fiddles
> with xstates. We all know by now that xstates is a trainwreck and not
> having stuff like that in there is making the fixes I'm doing way
> simpler.

As for the general sentiment that PKRU is not suitable for management
with XSAVE, I'm with you.

I have a few concerns about moving away from XSAVE management, though.
I'm not nixing the whole idea, but there are some things we need to resolve.

First is that there _may_ be ABI concerns.  The pkey selftest, for
instance, manipulates the PKRU state on the signal stack and expects
PKRU to be set in XCR0 so that it can do this.  I wouldn't be shocked if
some other pkey user depended on the XSAVE signal stack ABI this way.

There are also the usual concerns that folks doing user-level context
switching or other insanity get PKRU context switching for "free" when
it's XSAVE-managed.  Moving away from that could break them.

I'll ask around.  We could also pretty trivially put some surveillance
in the sigreturn code to look for PKRU changes.

Second, the XSAVE/FPU abomination is actually really handy for pkeys:
1. It establishes a *different* state upon signal delivery.  Like
   sigaltstack, this means that the signal handler can recover from
   what would normally be a fatal condition like WRPKRU(0x3).  I *think*
   this is OK today even if the signal entry XRSTOR did not touch PKRU
   since there's another write_pkru() in this path.
2. It allows the signal handler to inspect the interrupted context's
   PKRU value. (used in the selftest)
3. It allows the signal handler to *override* the PKRU value of the
   interrupted context.  This is used in the selftest as an easy way
   to let a memory access instruction execute that initially causes
   a pkey-induced page fault as opposed to messing with RIP.

None of this is insurmountable.  For the selftest, I need to go looking
at how important that functionality is and look for some alternatives.
