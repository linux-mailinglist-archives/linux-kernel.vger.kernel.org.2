Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70ECB375F83
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 06:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhEGEil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 00:38:41 -0400
Received: from mail-mw2nam10on2048.outbound.protection.outlook.com ([40.107.94.48]:51934
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231667AbhEGEik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 00:38:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PV0O6QdRIwUNxsGK8oxRpZXo+wTzytrnTjA62FMckMPoh0ikk5/clXcv6pllgvb8N+N9WbXS/wtg4j/8hHA755wsgHTOP0E1ty0vTLmiEnOITB2UCUgT3GO+zvN4Q95I2EvTCJRBchlq8KTl/ajreHoJLsxCyDi4pGMyeSaQ9d88vT4PhT0cGSQoaP7o92qS5H+rYk/oMpN4HDjJoPBtGV1qtBK2aSY24BJpT1tFr5hivowx0S9uIjY5a93sO//m1uLpuxbNJhhk9MWxCqfcI9gDjwSiNYqLFgvdf/K5T+I/zmGlpgu5RDufG1uUNs2p+1XbFV6blCj/yRNOLn/yxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=809vEoBeLo87Av2xyVwt8tMrSuFGUxd3A7hvTA7g1sA=;
 b=N/kUOvnXa5dngnOHrf8t637T3laFo8EC7nHvloJQ0qk1AmtpG5q8c5aeXiLCJiYoYYBk+eO3pjoikHQMBL1A5bo4+5beDHvysW7hyDgVD3udiBQgJAfnA3A4nwmlUotv8It9o6JGIh6LBiBSpdfkxHY/6B79DuRkrcYrqXsvVOWvua93io0n1paYEha0Y46bOkkJbkJ+aMY6t/y8L0Q/r7U8clhzz4yf7wqzSwxec6n7jxzs80vpOATDMRsgJZGXvdLagzcm1ZjZ2C95xpGUiKPUBz4wYEn+ks/TazSWJBmRIn/+s/TIAlUKnoa/KbUYsT3cUwcn/yBZUcn/w/8pqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=suse.cz smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=809vEoBeLo87Av2xyVwt8tMrSuFGUxd3A7hvTA7g1sA=;
 b=SOXXAegredwuOMyVrUEjNN8CPvZ/cwJcgVlGGUc04gQKySyFB1ag5HdQlg3iGH0t9wtjGbgj5bDVNAdjKS6McKVNy4KR/JFWa50g2I50CYZxjx69oJTNSi6gEZQ9cyW6Ix9OL7cAqrNhH0tOEfiJDJTokME+Sbi2gLSyLgAvJesHDGS++ZgsU8A8icYT25LW2658skC9fseBtwZm0zRGL1s0C9F0yV7Izg/2zsOHLt7PwKY3URjLZhU8ivlHEyx6MjEad3cLNnKEA8mUaZxpmYXPFXXQZoUK2HziKUF2xuhI46SsnxHGrz5Yfn68OQe2H/Icmd/p2URFe28I3bsw6Q==
Received: from BN6PR13CA0031.namprd13.prod.outlook.com (2603:10b6:404:13e::17)
 by DM6PR12MB3451.namprd12.prod.outlook.com (2603:10b6:5:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 04:37:39 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::66) by BN6PR13CA0031.outlook.office365.com
 (2603:10b6:404:13e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.28 via Frontend
 Transport; Fri, 7 May 2021 04:37:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 04:37:38 +0000
Received: from [10.2.61.66] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 7 May
 2021 04:37:37 +0000
Subject: Re: [PATCH 1/3] mm/gup_benchmark: Support threading
To:     Peter Xu <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "Michal Hocko" <mhocko@suse.com>, Oleg Nesterov <oleg@redhat.com>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20210506232537.165788-1-peterx@redhat.com>
 <20210506232537.165788-2-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <a631bb81-a8a7-0423-4e7c-e0cf213e932b@nvidia.com>
Date:   Thu, 6 May 2021 21:37:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210506232537.165788-2-peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b90f6ef-deb2-421e-6443-08d91111d83f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3451:
X-Microsoft-Antispam-PRVS: <DM6PR12MB34513F7AA5EA2659AACC4045A8579@DM6PR12MB3451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q467FnFbU3Pm7XCRDBinLhMDHiZbq1OLJIO0TZf0ErwCL37Sz0d4+ThToCgKJ9BXdGoj17oODyZJnkK5YFWpoYHIzE25nBO0EoqpLmhv8GMRLkgxSyccBDMrPGQ97Q3zw75nz7Vr2QViB6nO12Da3eZsXCEPNntvF3gZTgu94J9nvbvUbiYmOM1KdeqUT6YS1mFX4E8qFNPWlIiE5oaodnd72yZQsmXJd54Uhb4nzBNCz4FhblsfAP4klAPgiH1+QUwwwmNOy+AtUpmWvqtWXBQD50whq5eGtrBiX3Q0Q2ewjhDSliH5k/XbswbWABOP6jXohmy1D4zc6WQmiPDp8eGuxea0sYFWIRsAX6znoj5ou1OJLj0jKe0Md6jVr4XvTuF/qKi4Q0932reLVx983VBkRjZRMDVlKicBtJCZ8Dm6RE12rF9GsU3c1FXIo/S2hxHPDjNCw4+KA4uJKWhUHdu9mbwkGXGgrSYgcaSgNQuJx151rz8UKN6gkAhFPfvLLWmXfa8GMWVNxiSwZCqheyqNf4PClCn0WNdM5EEEnUbkEcv/WgJdg/ejgVQUX/zEeDA5rVf+6TPy+BdNQDPLGleQ44thG5xx0DiYmbVdCyYh4fuzzonZKCW6fiYiEnJqkp/+JHcnGxNaZFS57xEMPuD30yfQ6nSS1TUklm8uPLaW8mGT9QfvLsJOQuWaj2ErB7whWXSIcHetWQ5hj/UrWw==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(36840700001)(46966006)(26005)(2906002)(426003)(16576012)(336012)(356005)(82740400003)(31696002)(83380400001)(70206006)(16526019)(36906005)(47076005)(110136005)(186003)(54906003)(70586007)(53546011)(316002)(36756003)(7636003)(478600001)(82310400003)(7416002)(8676002)(5660300002)(4326008)(31686004)(36860700001)(8936002)(2616005)(86362001)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 04:37:38.7896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b90f6ef-deb2-421e-6443-08d91111d83f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3451
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/21 4:25 PM, Peter Xu wrote:
> Add a new parameter "-j N" to support concurrent gup test.

I had a long-standing personal TODO item that said, "decide if it's
worth it, to add pthread support to gup_test". So now, at least one
other person has decided that it *is* worth it, and you've also written
the patch. OK, then. Sweet! :)

This looks correct to me. I have a couple of minor comments below, but
either way you can add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   tools/testing/selftests/vm/gup_test.c | 94 ++++++++++++++++++---------
>   1 file changed, 63 insertions(+), 31 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftests/vm/gup_test.c
> index 1e662d59c502a..3f0fcc697c3fc 100644
> --- a/tools/testing/selftests/vm/gup_test.c
> +++ b/tools/testing/selftests/vm/gup_test.c
> @@ -6,6 +6,7 @@
>   #include <sys/mman.h>
>   #include <sys/stat.h>
>   #include <sys/types.h>
> +#include <pthread.h>
>   #include "../../../../mm/gup_test.h"
>   
>   #define MB (1UL << 20)
> @@ -15,6 +16,12 @@
>   #define FOLL_WRITE	0x01	/* check pte is writable */
>   #define FOLL_TOUCH	0x02	/* mark page accessed */
>   
> +static unsigned long cmd = GUP_FAST_BENCHMARK;
> +static int gup_fd, repeats = 1;
> +static unsigned long size = 128 * MB;
> +/* Serialize prints */
> +static pthread_mutex_t print_mutex = PTHREAD_MUTEX_INITIALIZER;
> +
>   static char *cmd_to_str(unsigned long cmd)
>   {
>   	switch (cmd) {
> @@ -34,17 +41,55 @@ static char *cmd_to_str(unsigned long cmd)
>   	return "Unknown command";
>   }
>   
> +void *gup_thread(void *data)
> +{
> +	struct gup_test gup = *(struct gup_test *)data;
> +	int i;
> +
> +	/* Only report timing information on the *_BENCHMARK commands: */
> +	if ((cmd == PIN_FAST_BENCHMARK) || (cmd == GUP_FAST_BENCHMARK) ||
> +	     (cmd == PIN_LONGTERM_BENCHMARK)) {
> +		for (i = 0; i < repeats; i++) {
> +			gup.size = size;
> +			if (ioctl(gup_fd, cmd, &gup))
> +				perror("ioctl"), exit(1);
> +
> +			pthread_mutex_lock(&print_mutex);
> +			printf("%s: Time: get:%lld put:%lld us",
> +			       cmd_to_str(cmd), gup.get_delta_usec,
> +			       gup.put_delta_usec);
> +			if (gup.size != size)
> +				printf(", truncated (size: %lld)", gup.size);
> +			printf("\n");
> +			pthread_mutex_unlock(&print_mutex);
> +		}
> +	} else {
> +		gup.size = size;
> +		if (ioctl(gup_fd, cmd, &gup)) {
> +			perror("ioctl");
> +			exit(1);
> +		}
> +
> +		pthread_mutex_lock(&print_mutex);
> +		printf("%s: done\n", cmd_to_str(cmd));
> +		if (gup.size != size)
> +			printf("Truncated (size: %lld)\n", gup.size);
> +		pthread_mutex_unlock(&print_mutex);
> +	}
> +
> +	return NULL;
> +}
> +
>   int main(int argc, char **argv)
>   {
>   	struct gup_test gup = { 0 };
> -	unsigned long size = 128 * MB;
> -	int i, fd, filed, opt, nr_pages = 1, thp = -1, repeats = 1, write = 1;
> -	unsigned long cmd = GUP_FAST_BENCHMARK;
> +	int filed, i, opt, nr_pages = 1, thp = -1, write = 1, threads = 1;


"nthreads" is a little more accurate for this.


>   	int flags = MAP_PRIVATE, touch = 0;
>   	char *file = "/dev/zero";
> +	pthread_t *tid;
>   	char *p;
>   
> -	while ((opt = getopt(argc, argv, "m:r:n:F:f:abctTLUuwWSHpz")) != -1) {
> +	while ((opt = getopt(argc, argv, "m:r:n:F:f:abcj:tTLUuwWSHpz")) != -1) {
>   		switch (opt) {
>   		case 'a':
>   			cmd = PIN_FAST_BENCHMARK;
> @@ -74,6 +119,9 @@ int main(int argc, char **argv)
>   			/* strtol, so you can pass flags in hex form */
>   			gup.gup_flags = strtol(optarg, 0, 0);
>   			break;
> +		case 'j':
> +			threads = atoi(optarg);
> +			break;
>   		case 'm':
>   			size = atoi(optarg) * MB;
>   			break;
> @@ -154,8 +202,8 @@ int main(int argc, char **argv)
>   	if (write)
>   		gup.gup_flags |= FOLL_WRITE;
>   
> -	fd = open("/sys/kernel/debug/gup_test", O_RDWR);
> -	if (fd == -1) {
> +	gup_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
> +	if (gup_fd == -1) {
>   		perror("open");
>   		exit(1);
>   	}
> @@ -185,32 +233,16 @@ int main(int argc, char **argv)
>   			p[0] = 0;
>   	}
>   
> -	/* Only report timing information on the *_BENCHMARK commands: */
> -	if ((cmd == PIN_FAST_BENCHMARK) || (cmd == GUP_FAST_BENCHMARK) ||
> -	     (cmd == PIN_LONGTERM_BENCHMARK)) {
> -		for (i = 0; i < repeats; i++) {
> -			gup.size = size;
> -			if (ioctl(fd, cmd, &gup))
> -				perror("ioctl"), exit(1);
> -
> -			printf("%s: Time: get:%lld put:%lld us",
> -			       cmd_to_str(cmd), gup.get_delta_usec,
> -			       gup.put_delta_usec);
> -			if (gup.size != size)
> -				printf(", truncated (size: %lld)", gup.size);
> -			printf("\n");
> -		}
> -	} else {
> -		gup.size = size;
> -		if (ioctl(fd, cmd, &gup)) {
> -			perror("ioctl");
> -			exit(1);
> -		}
> -
> -		printf("%s: done\n", cmd_to_str(cmd));
> -		if (gup.size != size)
> -			printf("Truncated (size: %lld)\n", gup.size);
> +	tid = malloc(sizeof(pthread_t) * threads);
> +	if (!tid) {
> +		perror("malloc()");
> +		exit(1);
>   	}
> +	for (i = 0; i < threads; i++)
> +		pthread_create(&tid[i], NULL, gup_thread, &gup);

It might be nice to check the return value of pthread_create(), and
just exit out with an error if it fails. On the other hand, it seems
spectacularly unlikely for it to fail here...on the other-other hand,
I always say that, just before writing code that doesn't check an
error, and the error somehow happens anyway and costs someone some
wasted time.

Your call.

> +	for (i = 0; i < threads; i++)
> +		pthread_join(tid[i], NULL);
> +	free(tid);
>   
>   	return 0;
>   }
> 

thanks,
-- 
John Hubbard
NVIDIA
