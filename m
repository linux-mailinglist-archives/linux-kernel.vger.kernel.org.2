Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F32447D02
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 10:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbhKHJrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 04:47:21 -0500
Received: from mail-dm6nam12on2061.outbound.protection.outlook.com ([40.107.243.61]:34447
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233614AbhKHJrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 04:47:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7dKeM0mpJdOnShYjJPbYcgi/Bv9aGA6ldYOr5E9d9k9tsZ8HqKhOL3At4go7pCP6iNMtPzPLaMG6xV024Pf04tfYmT3oemaGWISbjWAatQF4UGEUGdbXLp/1fmnlsYU7RaQb65wyXZ9tFp/bp8LR8nisxALf3o4ValB9m27hdFtFuZpIY6jMj6rGL3v1+eU1KQxOfHkb0LC6BDRZRCGd7SIJM835gUQamUTCgsrT5xCQ2QeIeQ75oW1XHPLGDJ8SernSTBEPYJ9W6qAHa6Np7qmbOzHE73eG+1O2HbZj08h/nSv3Hk/vfsFQ1qQtsK00PL+2oi9cNPPvYSLNxNjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jw3q580MKplaMFshlLn9hHR76tOMr1n4nOR1w0lE50k=;
 b=X1/OnP7r/0fQBJSlPQHNr8DiSJ2LYnrWnQt9HSaopfWHMKCRP4qkQ8A8VcnayfxItdRIA7utyLdSAcT2WXffztMJu4PCPznm9Th+zM9lwNjUehDD2i9aZnSYuiljBLCpmsPgPEj6HMoOT4ledAjORfMTXLO/rzudyXu11+UEGC97YMo1uyz4EZ2ihjKTV26wEITcpDOW9bFDLRxTMdmGa00GMrWpFqYK0GrQeLBaLzN6Ar8JUyhKSeywx59TIeYLaQqg5Q9HcPEAR8iDbgYvwvysY1N3+LkVdHw2saZTKP52kfeH10tszrKzLVRPceyfmBwICMukVJhOS4WeFyf+tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jw3q580MKplaMFshlLn9hHR76tOMr1n4nOR1w0lE50k=;
 b=lJ6v+4/e1nnmGqwMYO7lX7E6fQfp2hzi7eeXIMsk5wQJz1dfny4x4PySuhv52LQFnEy/DlGke5slSi+91Pburxw2Sby60jTdLcuCo/tS/pZshCHFZTZjTzDlCeOEsFlJtfYhWxH9Wjuw/WCsUGcAqSWWtl4wGc0bkpM/5JT0Ep4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB3513.namprd12.prod.outlook.com (2603:10b6:5:18a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.16; Mon, 8 Nov 2021 09:44:34 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa%6]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 09:44:34 +0000
Date:   Mon, 8 Nov 2021 17:44:25 +0800
From:   Lang Yu <Lang.Yu@amd.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/kmemleak: Avoid scanning potential huge holes
Message-ID: <YYjxedn98jVhofba@lang-desktop>
References: <20211105035241.1239751-1-lang.yu@amd.com>
 <db19fb83-7a96-605e-65ba-10e01391530d@redhat.com>
 <YYjRcGEW+snSyppV@lang-desktop>
 <52d4711c-8034-d81f-865f-ff45e4359cad@redhat.com>
 <YYjomTdnLg4L6ppm@lang-desktop>
 <a82d57cc-c99a-406c-15b7-3e92975dc452@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a82d57cc-c99a-406c-15b7-3e92975dc452@redhat.com>
X-ClientProxiedBy: HK0PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:203:b0::32) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
Received: from lang-desktop (165.204.134.244) by HK0PR03CA0116.apcprd03.prod.outlook.com (2603:1096:203:b0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend Transport; Mon, 8 Nov 2021 09:44:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3112087-08b0-4a34-4fd8-08d9a29c5edf
X-MS-TrafficTypeDiagnostic: DM6PR12MB3513:
X-Microsoft-Antispam-PRVS: <DM6PR12MB351394618C8B3C3A6C0BAB54FB919@DM6PR12MB3513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D8j9NM6qQeq+soyUJVkKCOnZY+sNRTn9Yq+26tH5TVfQvo700c2+rnl+5IEl9ujJ3Rw+TQfc189MGEJfPAI2zw2chPQiUkpt119hcp7pGLepbNd2K6TvifbIGU2H+KiF8XRLPusUOMVXwhK4016VhvcNMU14+sZHvoe1Id2+2ef7kafDqIghFMfNFx39NjaQO5TpAPusyFKpEhwexPd4VGZ7QK2oAFNflqKBLuvI1b7ZI0tvfHfeA7i1+z2YtRGpF8syiAZPBEsVVsNps3DxHmwJysByi29+WNf5WV0wJqDCfw+tvFE9Go0HV+zGk1cUt6tVjflvFn/Kp/woJEAkwgf6UgftAeURP2tZIoLJ3DpJcDHZaOfU/l/G1eSnv1BYz7/gFF/5DHDhESVQ3ZFK7cPE1UWZDHq8d9V6r/qyWxP8XiocVduTRJouCmo8nmMsvLlZCX+V+U4bzh15V2T8dtckecb33AchHvrQWQzvvIZ7WmTUuhLWoaL954vw+VYP1C66M9jRftWTm6brZDpVHBk/Q2uRv9sCOQO9SEMmKqFCccfT1MUu5QhZ7UQ5V0rc+joZSY26WUjzPOxPkPnDpzUqusshmeFNxA8an0k4rQxF7ZvzOgwsxofs1x82Yqspxgd/bkqlf0ThbUvfv54PvLTDf7AS7gNLSlPSrGZeVIUFkO79XkDGaWoNkNbv6MCIdL3yq6ug4WcYDLuNpnJQWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4250.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(186003)(9686003)(54906003)(8936002)(66556008)(38100700002)(8676002)(508600001)(316002)(26005)(55016002)(6666004)(66476007)(66946007)(4326008)(6916009)(2906002)(6496006)(5660300002)(83380400001)(86362001)(33716001)(956004)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kmUR1BOs0m58UFRgjt77hzsw6p9thtZgjiZtq+7hfR2Mj5Pg3ZVHUOzqjIYn?=
 =?us-ascii?Q?6aawLfR2+nqm9g4HFdpK7rGVgWGCI28tIxAjgIsOk76XrQ3hdG4rF45LEQzb?=
 =?us-ascii?Q?CRH/S/ZWAG4vjo/rbZlSJZ4FEomEx+x+A5kSZEav7GErNWtRIV7BZyxxm15h?=
 =?us-ascii?Q?1GXi96/HxhzZ14Xl87QYMBFb8coZ4beqb0xO2VyCxXnrhWYOoUcziXpcLxcl?=
 =?us-ascii?Q?17+8+hwxP/bCA/M6sNae4SCffG8jllyS8TMf0ReA66qL/6JfPDw25oCITwFy?=
 =?us-ascii?Q?BSPvIQdD6wO3+oTy0wabmstrPZUR1rHe1sNc4h+EntM8TILmwNo89uXs9xYQ?=
 =?us-ascii?Q?xs0L+saUSTOGpN8RiGaOt0NfbNkrZkb03lF/NNeDzfp7X4/5igYBi/LaIF09?=
 =?us-ascii?Q?zeS8e5xf996Z8FzjyQc/HYZD+zPP15T+F7n4y0Idb2d46cLehCrjzqvyyU0D?=
 =?us-ascii?Q?cXuk0bElEYBXiI9wnY9OCumKp35ROIN2IC8SqDFx8zaBO+pD4fT0KDxqZ7n0?=
 =?us-ascii?Q?u2r1P3lwKRmUb6a5Z152lXdjBGotjNP9O6VGEdAheO59k1RwwcvdcLyj57Ax?=
 =?us-ascii?Q?9Kc6Y/as0yPY9BgiVhRRnz2ZLCnmTJBf0QxaDvVG09O8PNOALfAPv9HDX2br?=
 =?us-ascii?Q?x2wu3JloytWaDwr097ZbweqG6DsHWahXM0y58TFG00a9Mv44w4r+kcRYIRxq?=
 =?us-ascii?Q?K36UL8AnWabT9uqn+WSmMG4fWVVqjsnuU33nzJrEVUITNv1cxhxt8VbP2kVa?=
 =?us-ascii?Q?r0X0rFA+dbhR/RktjoMUjSftlTV/x65wVxH1bt4cfhlR3JxcrODJWRI2r6kd?=
 =?us-ascii?Q?7hIHIHp50LXuU0Y5/XRjLuWAiQ4GyjVubqAchRR+0QsTSROKjRZ8tJrT7cDI?=
 =?us-ascii?Q?ARXGkC6qc1isqbtDcPKueXvLIyyZBQJN7ffk42t7ijsWecf0tYeH2ElU4Ou+?=
 =?us-ascii?Q?TbMJGiwI/6fau/ME4COAKIQp2Awi6733+a9mdfEJqe9VcWzsAWd6A3MpMAlj?=
 =?us-ascii?Q?UEuXDTmIOOFU1ulWwMr3ts3FVfu7Rr4/5F0z+s65pVENhKZA7rNhkjYysgLv?=
 =?us-ascii?Q?vYNfcG2p8m8falzu5DG0KVFL0YGCPSjTbG/sV9rL76AIcUROAxw10O76ZCFa?=
 =?us-ascii?Q?T+kcCP/l1j1L9VrBa+wxZcDY28bbNJNTJ3q7aGJV0H+tQs5b2Wi3/pEobyQu?=
 =?us-ascii?Q?bPr2gQuDdnzUmB/8h6cXcH63yG7HIy/fgOoar2WV+070p6+BwNxjwk6x7Adx?=
 =?us-ascii?Q?rInVVR8iHL8RdSmc2bt6n4GD8IQLkRE6SFetspva3noN+W4Dis9YzhiiMef2?=
 =?us-ascii?Q?xQfmUq9oNGWB0YK3YM1YTAvrn7G2jot+QdGzbu7C4q0gF8+0RmJEVuc6qVtX?=
 =?us-ascii?Q?etF5ZvO5V8LW5hQjISqeyqaEmy4KextLw1fEN97HVg3HQIWYGsw9C8wopQUr?=
 =?us-ascii?Q?HY7Jt1LtqBdbsEu8Bv5cV7iORm5ldW5SByZJ1UaS+gLfPdUMiWJAYzZqJGAl?=
 =?us-ascii?Q?HfbaJIWNTpjh+uAs6vO9kNYNFcDnrW2wRV87nswoaMhtHzggk5ldN8QntHXB?=
 =?us-ascii?Q?3rj8M5hJWXsDIEAU66wQM5caRId+hyE9nCoGWSHECPu24cnxVWzsVLutdWWp?=
 =?us-ascii?Q?WLHY3JQ4OqNRR5xVxtpxXdM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3112087-08b0-4a34-4fd8-08d9a29c5edf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 09:44:34.1111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKVkO549kGWU0Sq+n/XmQZIP/lSTcE40ibfaXTi3zGt7tRG6I8IaEn+eExe8/r9UMsR9zB2uJGb2jxCRL/u+9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3513
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 10:24:43AM +0100, David Hildenbrand wrote:
> On 08.11.21 10:06, Lang Yu wrote:
> > On Mon, Nov 08, 2021 at 09:23:16AM +0100, David Hildenbrand wrote:
> >> On 08.11.21 08:27, Lang Yu wrote:
> >>> On Fri, Nov 05, 2021 at 02:14:50PM +0100, David Hildenbrand wrote:
> >>>> On 05.11.21 04:52, Lang Yu wrote:
> >>>>> When using devm_request_free_mem_region() and
> >>>>> devm_memremap_pages() to add ZONE_DEVICE memory, if requested
> >>>>> free mem region pfn were huge(e.g., 0x400000000 ,we found
> >>>>> on some amd apus, amdkfd svm will request a such free mem region),
> >>>>> the node_end_pfn() will be also huge(see move_pfn_range_to_zone()).
> >>>>> It creates a huge hole between node_start_pfn() and node_end_pfn().
> >>>>>
> >>>>> In such a case, following code snippet acctually was
> >>>>> just doing busy test_bit() looping on the huge hole.
> >>>>>
> >>>>> for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> >>>>> 	struct page *page = pfn_to_online_page(pfn);
> >>>>> 		if (!page)
> >>>>> 			continue;
> >>>>> 	...
> >>>>> }
> >>>>>
> >>>>> So we got a soft lockup:
> >>>>>
> >>>>>  watchdog: BUG: soft lockup - CPU#6 stuck for 26s! [bash:1221]
> >>>>>  CPU: 6 PID: 1221 Comm: bash Not tainted 5.15.0-custom #1
> >>>>>  RIP: 0010:pfn_to_online_page+0x5/0xd0
> >>>>>  Call Trace:
> >>>>>   ? kmemleak_scan+0x16a/0x440
> >>>>>   kmemleak_write+0x306/0x3a0
> >>>>>   ? common_file_perm+0x72/0x170
> >>>>>   full_proxy_write+0x5c/0x90
> >>>>>   vfs_write+0xb9/0x260
> >>>>>   ksys_write+0x67/0xe0
> >>>>>   __x64_sys_write+0x1a/0x20
> >>>>>   do_syscall_64+0x3b/0xc0
> >>>>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>>>>
> >>>>> I did some tests with the patch.
> >>>>>
> >>>>> (1) amdgpu module unloaded
> >>>>>
> >>>>> before the patch:
> >>>>>
> >>>>> real    0m0.976s
> >>>>> user    0m0.000s
> >>>>> sys     0m0.968s
> >>>>>
> >>>>> after the patch:
> >>>>>
> >>>>> real    0m0.981s
> >>>>> user    0m0.000s
> >>>>> sys     0m0.973s
> >>>>>
> >>>>> (2) amdgpu module loaded
> >>>>>
> >>>>> before the patch:
> >>>>>
> >>>>> real    0m35.365s
> >>>>> user    0m0.000s
> >>>>> sys     0m35.354s
> >>>>>
> >>>>> after the patch:
> >>>>>
> >>>>> real    0m1.049s
> >>>>> user    0m0.000s
> >>>>> sys     0m1.042s
> >>>>>
> >>>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
> >>>>> ---
> >>>>>  mm/kmemleak.c | 9 +++++----
> >>>>>  1 file changed, 5 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> >>>>> index b57383c17cf6..d07444613a84 100644
> >>>>> --- a/mm/kmemleak.c
> >>>>> +++ b/mm/kmemleak.c
> >>>>> @@ -1403,6 +1403,7 @@ static void kmemleak_scan(void)
> >>>>>  {
> >>>>>  	unsigned long flags;
> >>>>>  	struct kmemleak_object *object;
> >>>>> +	struct zone *zone;
> >>>>>  	int i;
> >>>>>  	int new_leaks = 0;
> >>>>>  
> >>>>> @@ -1443,9 +1444,9 @@ static void kmemleak_scan(void)
> >>>>>  	 * Struct page scanning for each node.
> >>>>>  	 */
> >>>>>  	get_online_mems();
> >>>>> -	for_each_online_node(i) {
> >>>>> -		unsigned long start_pfn = node_start_pfn(i);
> >>>>> -		unsigned long end_pfn = node_end_pfn(i);
> >>>>> +	for_each_populated_zone(zone) {
> >>>>> +		unsigned long start_pfn = zone->zone_start_pfn;
> >>>>> +		unsigned long end_pfn = zone_end_pfn(zone);
> >>>>>  		unsigned long pfn;
> >>>>>  
> >>>>>  		for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> >>>>> @@ -1455,7 +1456,7 @@ static void kmemleak_scan(void)
> >>>>>  				continue;
> >>>>>  
> >>>>>  			/* only scan pages belonging to this node */
> >>>>> -			if (page_to_nid(page) != i)
> >>>>> +			if (page_to_nid(page) != zone_to_nid(zone))
> >>>>
> >>>> With overlapping zones you might rescan ranges ... instead we should do:
> >>>>
> >>>> /* only scan pages belonging to this zone */
> >>>> if (zone != page_zone(page))
> >>>> 	...
> >>>>
> >>>> Or alternatively:
> >>>>
> >>>> /* only scan pages belonging to this node */
> >>>> if (page_to_nid(page) != zone_to_nid(zone))
> >>>> 	continue;
> >>>> /* only scan pages belonging to this zone */
> >>>> if (page_zonenum(page) != zone_idx(zone))
> >>>> 	continue;
> >>>
> >>> The original code has covered that, i.e., 
> >>> only scan pages belonging to this node.
> >>> I didn't change that behavior.
> >>
> >> Again, you can easily have overlapping zones -- ZONE_NORMAL and
> >> ZONE_MOVABLE -- in which case, a PFN is spanned by multiple zones, but
> >> only belongs to a single zone.
> >>
> >> The original code would scan each PFN exactly once, as it was iterating
> >> the node PFNs. Your changed code might scan a single PFN multiple times,
> >> if it's spanned by multiple zones.
> >>
> > 
> > Did you mean a single PFN is shared by multiple zones belonging to the 
> > same node here? Thanks!
> 
> Not shared, spanned. A PFN always belongs to exactly one ZONE+NODE, but
> might be "spanned" by multiple nodes or multiple zones, because nodes
> and zones can overlap We can get the actual zone of a PFN via
> page_zone(page) in my example above. Note that checking for the zone
> structure (not the zone number/idx) implicitly checks for the node.
> 
> 
> Let's take a look at an example:
> 
> ...
> [root@vm-0 ~]# cat /sys/devices/system/memory/memory32/valid_zones
> Normal
> [root@vm-0 ~]# cat /sys/devices/system/memory/memory33/valid_zones
> Normal
> [root@vm-0 ~]# cat /sys/devices/system/memory/memory34/valid_zones
> Normal
> [root@vm-0 ~]# cat /sys/devices/system/memory/memory35/valid_zones
> Normal
> [root@vm-0 ~]# cat /sys/devices/system/memory/memory36/valid_zones
> Normal
> [root@vm-0 ~]# cat /sys/devices/system/memory/memory37/valid_zones
> Normal
> [root@vm-0 ~]# cat /sys/devices/system/memory/memory38/valid_zones
> Normal
> [root@vm-0 ~]# cat /sys/devices/system/memory/memory39/valid_zones
> Normal
> [root@vm-0 ~]# cat /sys/devices/system/memory/memory40/valid_zones
> Movable
> [root@vm-0 ~]# cat /sys/devices/system/memory/memory41/valid_zones
> Normal
> [root@vm-0 ~]# cat /sys/devices/system/memory/memory42/valid_zones
> Movable
> [root@vm-0 ~]# cat /sys/devices/system/memory/memory43/valid_zones
> Normal
> [root@vm-0 ~]# cat /sys/devices/system/memory/memory44/valid_zones
> Movable
> [root@vm-0 ~]# cat /sys/devices/system/memory/memory45/valid_zones
> Normal
> [root@vm-0 ~]# cat /sys/devices/system/memory/memory46/valid_zones
> Movable
> [root@vm-0 ~]# cat /sys/devices/system/memory/memory47/valid_zones
> Normal
> [root@vm-0 ~]# cat /sys/devices/system/memory/memory48/valid_zones
> 
> 
> # cat /proc/zoneinfo
> Node 0, zone      DMA
> 	...
>         spanned  4095
>         present  3998
>         managed  3977
> 	...
>   start_pfn:           1
> Node 0, zone    DMA32
> 	...
>         spanned  1044480
>         present  782304
>         managed  765920
> 	...
>   start_pfn:           4096
> Node 0, zone   Normal
> 	...
>         spanned  524288
>         present  393216
>         managed  365736
> 	...
>   start_pfn:           1048576
> Node 0, zone  Movable
> 	...
>         spanned  229376
>         present  131072
>         managed  131072
>   start_pfn:           1310720
> 
> 
> So Normal spans:
> 
> 1048576 -> 1572863
> 
> And Movable spans:
> 
> 1310720 -> 1540095
> 
> Both zones overlap.

Thanks for your clarification! I got it.

Regards,
Lang

> -- 
> Thanks,
> 
> David / dhildenb
> 
