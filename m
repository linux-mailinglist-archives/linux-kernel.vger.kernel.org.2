Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E25A447B29
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 08:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237782AbhKHHbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 02:31:16 -0500
Received: from mail-bn1nam07on2070.outbound.protection.outlook.com ([40.107.212.70]:51270
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236429AbhKHHan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 02:30:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQeVowhGAgbj0c5zIZ6LZmOOnMGKombG/JhCpVw6alsZxnKWR9z6uSkhHsEzbP54UxNcWfdXjOLtiAW9jV773ODXc0660b+p/cQHweic7+4m/Bf9uSeshe/4zsDpRlJWJMLFEPOYVkrWpBEnVZtEWe4iDPVY2FtlAAB2yubTOhdlGz0zNmEvq6lBnC3dFt7mXaOQxXlrbpkTlwGfmm5eHzm8nOQ47RIj4ioCGhJLzhNfPjdugVWSvCgjDnX6Pr5ccc6t27xuSTEovURbjP7U4J5gmr6Q1EmNGhArm2GnaaynhaMO7ac4VWLYU2DdNRJ2QR4Wxg1VPiVvNakMKPwYag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7tU1qS7h0lZUoGx5lemtX5N1ulAbhdEpEx90lk4O+o=;
 b=LbPHbHsrKWHKQOku2okXSZYNl0Wkg8V5ssDFG8DK+wwnAc6f8sabeS3T3mU0qf1lU7p4ISqyvq4lvZ4IQv0jL8pFmiPzBbx+jNyK6ct6B3xvInp7luVY+skVf2fwo0YzHqgBaNJTDj7xGoblMkirRG7bSSqVy+HfeS+wbt6RqRFi/Ft/IrPP9udw5O03rbNgmuxlDuP4HSiw2j6EO4AlEOKtOmq1JtikDVxtEabIDRy7LVM9MpjHRfK9wM1PHDBu5EibMAGAQc7kvoBmuLfgxt4g+E+JPONvsX+L9lZbsScgdmfE5rvHJHyelyuz58M3ap1pdEuSOfIOi5RiFOsX2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7tU1qS7h0lZUoGx5lemtX5N1ulAbhdEpEx90lk4O+o=;
 b=AUhqnkyeCEF47x3wCnWwRqnyDv8caD1tGbn7LBQ3J7y0+hCaq1W5C7SmxNVUkiDlJ6xbMQWlIh3Q0ajzxGE/0/Q//2xfVLeBkxmC4RF5EzSGEUNzsNq4AZfbG07PKndYdaFI6m8DcHch0mAS6ddFPMliv7MfIW1/QATB/JKh9t4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR12MB1241.namprd12.prod.outlook.com (2603:10b6:3:72::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.13; Mon, 8 Nov 2021 07:27:56 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa%6]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 07:27:56 +0000
Date:   Mon, 8 Nov 2021 15:27:44 +0800
From:   Lang Yu <Lang.Yu@amd.com>
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/kmemleak: Avoid scanning potential huge holes
Message-ID: <YYjRcGEW+snSyppV@lang-desktop>
References: <20211105035241.1239751-1-lang.yu@amd.com>
 <db19fb83-7a96-605e-65ba-10e01391530d@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db19fb83-7a96-605e-65ba-10e01391530d@redhat.com>
X-ClientProxiedBy: SG2PR06CA0106.apcprd06.prod.outlook.com
 (2603:1096:3:14::32) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
Received: from lang-desktop (165.204.134.244) by SG2PR06CA0106.apcprd06.prod.outlook.com (2603:1096:3:14::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 07:27:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f63c34c9-4448-40f6-25fc-08d9a2894874
X-MS-TrafficTypeDiagnostic: DM5PR12MB1241:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1241D4AF6FA52DB8B8960DFAFB919@DM5PR12MB1241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tkGmvT+xsuVDAIPJ5oPUt1ceAWV71RpEc6Nguj07GL/LEgiGiiC3yRs1eOxMLL13y0w4JxH4eXLGPkYyovQ3/LC2e47anO+VIsIMi94j6y4dGJlpeHd2915yokI6Uru3efjnE333Nxcqe0XU/e3KI2w1Yzmbt2Cajd9lc9F99bCfqSzEoM1M7mCEz8QKo/x88vAa8OaCU8O0KGUWuL9Hf5QjDGMR5R5Qxv246IOvstlv/tSfFv7TaiitK77BmfG1MbrDBNSr9/6HT/WUBxGaU/W42gtSBOcOEesTOSlIbj1KmHG27c35bNVVMIQOvQkquUqDa4r1JoGXVKCJGNyRce8lTtkyenBPnX0rNBriT00xa3GxKexHHCLrSzFMEn1S0MXHYl8sznQqg8s5e+Qw4L29Iq0Ed7gpXOU6wv0k1/3Y5HsVyAVEfdlEgTRqwPTEpqFj/M2PtuFCN4C076ln2f9mPMw/zUavJryhlhoeW5DR+bklvNZsU4dGzhfOwvQ5iBXyhPdtnH8hKcOC/x9ECzM7E4Cf74R3wNXJp4hcCLC2LrCF4hH60N5T8Uu9DvYkSozbakz0F3WbVHAS8xM3khwEtkdp9H09g+53GuvH9vuqLvOsL4jKHxYGMW6FdfjFjMVAA6BtxO7zPh/EiSWZLenKdeK7LztOHrxPb2NwERGwhmzz3jki+S0UEtizQsRhFw7+9ERw8EMt+kNmz79Khinx0k4+KmwlIPCtWyeHZoY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4250.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(316002)(6666004)(2906002)(8936002)(4326008)(5660300002)(8676002)(110136005)(86362001)(6496006)(9686003)(53546011)(55016002)(38100700002)(33716001)(66556008)(186003)(66476007)(66946007)(83380400001)(956004)(26005)(14583001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+3jL1e+xLHoEHIsghU2dhbTV7oLzomQrW6JxE59FtjSYdUck89X9awiBe4jP?=
 =?us-ascii?Q?5rtYTvg/HQMA41wBP8+Yawka2cVuDNOvlGc5UWVQ5I+w/309WDHfss/75VFn?=
 =?us-ascii?Q?FstsjD63S8X1qsKjKQk7D12e2LmMF3vfEuuSJ83iThX+7+hKYD4dgBX6o1b5?=
 =?us-ascii?Q?6IGBVQZ8c5h4X+mo/2ZesImePIZe8D9xQIQTHfZDodJvxrSINAdy7zZuRhwY?=
 =?us-ascii?Q?SYym7rj6mrmUe/fUccw/+V09LmiSJHXwuKdSlbwBIidEm88u4M5jwtzt+yKx?=
 =?us-ascii?Q?dMI8IQ+TEry2ZidARoJx9Uwe0kak5Zjo51ycEt9whmu7u0YSBDj6tUbjtG6C?=
 =?us-ascii?Q?zVjYu5SusWvz5ijTM2f9HSCA4S5w33/aO02sBjiz9KF3HBCiAdB3SuKT7SLj?=
 =?us-ascii?Q?jiWI8rmPT0Nn01S1AKVvQ2eDsFcRaMfb2yj59b6NAv6WoioRzuZVvAW+jFK6?=
 =?us-ascii?Q?oC6z/8yIWVe5aasG+ioBJtb7yZC1yo+20u6Y+NhPSDn4NDezxfY0nK+7QRvL?=
 =?us-ascii?Q?HpjeFzflXucln24u/Ox1WSNS+hyZs8xVP1vvYfLQ5y8qFrmuwt9CXH3p7TfS?=
 =?us-ascii?Q?hUeSdekADE2plRspiFxIoGK6d/HzBsoIpUqN6huCHWyKQMSorZkzK4P+NuP3?=
 =?us-ascii?Q?dhp2HokvDDR82e06F8ZMUOn6+heg2raCjn/zLyyrcCawJWCoAQ6FjT63HdBN?=
 =?us-ascii?Q?VmyN/enL+WVhHe0fyDyaYIWl4lw11v7x6BwbQ0znDQYT1VzKpdZY796nGCBm?=
 =?us-ascii?Q?onp618Sj18Tk/qWSM/Vo6hghrNHeT47TMG7QLHRmo8fDn00BwqX0037YQJh1?=
 =?us-ascii?Q?Ty1M18vv5/7hWiVUMXV0yE5wfnFjR+Jug74LIfhd3yVGu3U4oo1+D3da10pe?=
 =?us-ascii?Q?j/KPG4sBOb6rkzXxzpkQK+HiCg/AubBqXBixFqZx32018gaIgORTSD0MxyQp?=
 =?us-ascii?Q?4W59KkQfKrQKVh7B/8lCyjFv/UyjV1FbzhKQr5Vp2yts3xHI4RvZpdNwXQTB?=
 =?us-ascii?Q?cXRyq7ryZYfRaYIWApa+VtobQsSrMNUkij3O1V8AgStHxeSC/KxPTuLxMUs5?=
 =?us-ascii?Q?6P/8SL3naVKh9LGXxA/WYRsy+IyGtNi8AITMyO879X5u5N2XP4stCc4w1t1j?=
 =?us-ascii?Q?W9GDz+uBEDVeCA7BIYP/3d5h3El/xb0D9DhHgZvWw0sq3KGv+KvE7ERFLSiv?=
 =?us-ascii?Q?2PYocmk/+TmXNpeVCS9rvw7k1R9sO/CDMqZaSguqxjgBqf+OTJOVMZeWak3b?=
 =?us-ascii?Q?520QfWyV3ZxlvxF4KBAuug5Stqrk0aGKKi3lQTeqfzBb+5lrNPsp9vB6GzCd?=
 =?us-ascii?Q?islXA+qdextpNoQ7KXPO4xgWEzdsIO+QPYkhM8q3E1dLaAmr4CgIeGLcPe0N?=
 =?us-ascii?Q?vNzAQ+e4BS3ay668Zk96mbpdjAJP6Pj2yzRLEb/CaRxcr/HaXoQyM7qBz52q?=
 =?us-ascii?Q?RynjKzgPiXy4MT03dljLzoPTL7CTk4zJqlICM7D/jPNnnXG08CX566og3Bl9?=
 =?us-ascii?Q?XgnoyI92h7tIj8HCukj8kCGhQQO6HpboDnOv9GtpU0iiILp5Q+HmSmeYV07S?=
 =?us-ascii?Q?THrIcqSUcjTiiCZCFrdMl4kVWNZtAE6LGONN95uzq4zxQo/Cxjjor+wgHGyG?=
 =?us-ascii?Q?0CgHTSu6o0A7wwL0Mzjjp2s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63c34c9-4448-40f6-25fc-08d9a2894874
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 07:27:56.3219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwbHHckCcUaPNmTg734HQHhd3nLgKPKmTi5l7X4KcAVlvllVt7avFd8dW2E9q6mHp+pz33qrEwcT7crB4osEiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1241
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 02:14:50PM +0100, David Hildenbrand wrote:
> On 05.11.21 04:52, Lang Yu wrote:
> > When using devm_request_free_mem_region() and
> > devm_memremap_pages() to add ZONE_DEVICE memory, if requested
> > free mem region pfn were huge(e.g., 0x400000000 ,we found
> > on some amd apus, amdkfd svm will request a such free mem region),
> > the node_end_pfn() will be also huge(see move_pfn_range_to_zone()).
> > It creates a huge hole between node_start_pfn() and node_end_pfn().
> > 
> > In such a case, following code snippet acctually was
> > just doing busy test_bit() looping on the huge hole.
> > 
> > for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> > 	struct page *page = pfn_to_online_page(pfn);
> > 		if (!page)
> > 			continue;
> > 	...
> > }
> > 
> > So we got a soft lockup:
> > 
> >  watchdog: BUG: soft lockup - CPU#6 stuck for 26s! [bash:1221]
> >  CPU: 6 PID: 1221 Comm: bash Not tainted 5.15.0-custom #1
> >  RIP: 0010:pfn_to_online_page+0x5/0xd0
> >  Call Trace:
> >   ? kmemleak_scan+0x16a/0x440
> >   kmemleak_write+0x306/0x3a0
> >   ? common_file_perm+0x72/0x170
> >   full_proxy_write+0x5c/0x90
> >   vfs_write+0xb9/0x260
> >   ksys_write+0x67/0xe0
> >   __x64_sys_write+0x1a/0x20
> >   do_syscall_64+0x3b/0xc0
> >   entry_SYSCALL_64_after_hwframe+0x44/0xae
> > 
> > I did some tests with the patch.
> > 
> > (1) amdgpu module unloaded
> > 
> > before the patch:
> > 
> > real    0m0.976s
> > user    0m0.000s
> > sys     0m0.968s
> > 
> > after the patch:
> > 
> > real    0m0.981s
> > user    0m0.000s
> > sys     0m0.973s
> > 
> > (2) amdgpu module loaded
> > 
> > before the patch:
> > 
> > real    0m35.365s
> > user    0m0.000s
> > sys     0m35.354s
> > 
> > after the patch:
> > 
> > real    0m1.049s
> > user    0m0.000s
> > sys     0m1.042s
> > 
> > Signed-off-by: Lang Yu <lang.yu@amd.com>
> > ---
> >  mm/kmemleak.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> > index b57383c17cf6..d07444613a84 100644
> > --- a/mm/kmemleak.c
> > +++ b/mm/kmemleak.c
> > @@ -1403,6 +1403,7 @@ static void kmemleak_scan(void)
> >  {
> >  	unsigned long flags;
> >  	struct kmemleak_object *object;
> > +	struct zone *zone;
> >  	int i;
> >  	int new_leaks = 0;
> >  
> > @@ -1443,9 +1444,9 @@ static void kmemleak_scan(void)
> >  	 * Struct page scanning for each node.
> >  	 */
> >  	get_online_mems();
> > -	for_each_online_node(i) {
> > -		unsigned long start_pfn = node_start_pfn(i);
> > -		unsigned long end_pfn = node_end_pfn(i);
> > +	for_each_populated_zone(zone) {
> > +		unsigned long start_pfn = zone->zone_start_pfn;
> > +		unsigned long end_pfn = zone_end_pfn(zone);
> >  		unsigned long pfn;
> >  
> >  		for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> > @@ -1455,7 +1456,7 @@ static void kmemleak_scan(void)
> >  				continue;
> >  
> >  			/* only scan pages belonging to this node */
> > -			if (page_to_nid(page) != i)
> > +			if (page_to_nid(page) != zone_to_nid(zone))
> 
> With overlapping zones you might rescan ranges ... instead we should do:
> 
> /* only scan pages belonging to this zone */
> if (zone != page_zone(page))
> 	...
> 
> Or alternatively:
> 
> /* only scan pages belonging to this node */
> if (page_to_nid(page) != zone_to_nid(zone))
> 	continue;
> /* only scan pages belonging to this zone */
> if (page_zonenum(page) != zone_idx(zone))
> 	continue;

The original code has covered that, i.e., 
only scan pages belonging to this node.
I didn't change that behavior.

Thanks,
Lang

> -- 
> Thanks,
> 
> David / dhildenb
> 
