Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FAB358F77
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 23:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbhDHVvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 17:51:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:10803 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232426AbhDHVvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 17:51:36 -0400
IronPort-SDR: iyCS6v4KfzQmLuzL45TX/gQpL/Yx+op4fc8ybtb5dGJMNX8E+9/WImifpApHrrBuZfbaKpxPnH
 PZ96zSrfaa5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="180768085"
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="180768085"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 14:51:21 -0700
IronPort-SDR: z02cTHaY3bIgDxHaabqoQzzIiuAvHzAwZAaOdOHiRjasjBanJFuXdyrw6OBsuhXyCKTaN3/Zu6
 IoU76fiwwpCA==
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="441911540"
Received: from mongkaiw-mobl.amr.corp.intel.com (HELO [10.209.62.147]) ([10.209.62.147])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 14:51:21 -0700
Subject: Re: [PATCH 02/10] mm/numa: automatically generate node migration
 order
To:     Oscar Salvador <osalvador@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        shy828301@gmail.com, weixugc@google.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com
References: <20210401183216.443C4443@viggo.jf.intel.com>
 <20210401183219.DC1928FA@viggo.jf.intel.com>
 <YG6+Gbs3C1MmYb7C@localhost.localdomain>
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
Message-ID: <ea67726a-c37a-e82f-feef-438dda0f5017@intel.com>
Date:   Thu, 8 Apr 2021 14:51:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YG6+Gbs3C1MmYb7C@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/21 1:26 AM, Oscar Salvador wrote:
> On Thu, Apr 01, 2021 at 11:32:19AM -0700, Dave Hansen wrote:
>> The protocol for node_demotion[] access and writing is not
>> standard.  It has no specific locking and is intended to be read
>> locklessly.  Readers must take care to avoid observing changes
>> that appear incoherent.  This was done so that node_demotion[]
> 
> It might be just me being dense here, but that reads odd.
> 
> "Readers must take care to avoid observing changes that appear
> incoherent" - I am not sure what is that supposed to mean.
> 
> I guess you mean readers of next_demotion_node()?
> And if so, how do they have to take care? And what would apply for
> "incoherent" terminology here?

I've fleshed out the description a bit.  I hope this helps?

> Readers of node_demotion[] (such as next_demotion_node() callers)
> must take care to avoid observing changes that appear incoherent.
> For instance, even though no demotion cycles are allowed, it's
> possible that a cycle could be observed.
> 
> Let's say that there are three nodes, A, B and C.  node_demotion[]
> is set up to have this path:
>         
>         A -> B -> C
> 
> Suppose it was modified to instead represent this path:
> 
>         A -> C -> B
> 
> There is nothing to stop a reader from seeing B->C and then a
> moment later seeting C->B.  That *appears* to be a cycle.  This
> can be avoided with RCU and will be implemented in a later patch.

...
>> +again:
>> +	this_pass = next_pass;
>> +	next_pass = NODE_MASK_NONE;
>> +	/*
>> +	 * To avoid cycles in the migration "graph", ensure
>> +	 * that migration sources are not future targets by
>> +	 * setting them in 'used_targets'.  Do this only
>> +	 * once per pass so that multiple source nodes can
>> +	 * share a target node.
>> +	 *
>> +	 * 'used_targets' will become unavailable in future
>> +	 * passes.  This limits some opportunities for
>> +	 * multiple source nodes to share a destination.
>> +	 */
>> +	nodes_or(used_targets, used_targets, this_pass);
>> +	for_each_node_mask(node, this_pass) {
>> +		int target_node = establish_migrate_target(node, &used_targets);
>> +
>> +		if (target_node == NUMA_NO_NODE)
>> +			continue;
>> +
>> +		/* Visit targets from this pass in the next pass: */
>> +		node_set(target_node, next_pass);
>> +	}
>> +	/* Is another pass necessary? */
>> +	if (!nodes_empty(next_pass))
> 
> When I read this I was about puzzled and it took me a while to figure
> out how the passes were made.
> I think this could benefit from a better explanation on how the passes
> are being performed e.g: why next_pass should be empty before leaving.
> 
> Other than that looks good to me.
I've tried to flesh out those comments to elaborate on what is going on:

>                 /*
>                  * Visit targets from this pass in the next pass.
>                  * Eventually, every node will have been part of
>                  * a pass, and will become set in 'used_targets'.
>                  */
>                 node_set(target_node, next_pass);
>         }
>         /*
>          * 'next_pass' contains nodes which became migration
>          * targets in this pass.  Make additional passes until
>          * no more migrations targets are available.
>          */
>         if (!nodes_empty(next_pass))
>                 goto again;
> }

