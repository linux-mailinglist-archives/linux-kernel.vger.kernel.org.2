Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E1F308443
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 04:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhA2Dej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 22:34:39 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:41289 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229757AbhA2Def (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 22:34:35 -0500
X-AuditID: 0a580157-f21ff7000005df43-dc-60137c8dff8e
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 66.51.57155.D8C73106; Fri, 29 Jan 2021 11:10:05 +0800 (HKT)
Received: from aili-OptiPlex-7020 (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 11:33:39 +0800
Date:   Fri, 29 Jan 2021 11:33:34 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     <x86@kernel.org>, <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>, <yangfeng1@kingsoft.com>
Subject: Re: [PATCH] x86/fault: Send SIGBUS to user process always for
 hwpoison page access.
Message-ID: <20210129113334.344377ac.yaoaili@kingsoft.com>
In-Reply-To: <20210128174352.GA33283@agluck-desk2.amr.corp.intel.com>
References: <20210128194326.71895e92.yaoaili@kingsoft.com>
        <20210128174352.GA33283@agluck-desk2.amr.corp.intel.com>
Organization: Kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/EexqPCuWxTsNhVXLba=9wVX"
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LhimBU0O2tEU4wOLqSz+LyrjlsFhcbDzBa
        vLlwj8Xix4bHrA4sHov3vGTy2LSqk83jxdWNLB6fN8kFsERx2aSk5mSWpRbp2yVwZVz78pil
        YO0KxoqXy3oYGxgPNDB2MXJySAiYSDw58ZC1i5GLQ0hgOpPEkR8/WUASQgIvGCX+TjIDsVkE
        VCV+nD7NDGKzAdm77s1iBbFFBNQkLi1+ABZnFsiW6Ll/nAnEFhaIkzjRdw+shlfASuLstd1g
        yzgFXCUer78ENb9U4vHtRUBxDg5+ATGJVw3GEPfYSzz/e5YZolVQ4uTMJywQ410lmg6tZYJo
        VZQ4vOQXO0S9ksSR7hlsEHasxLJ5r1gnMArNQtI+C0k7hK0jcWLVMWYIW15i+9s5QDYHkC0t
        sfwfB0QYyJx1kR1VCYhtKbF7xyTmBYwcqxhZinPTDTcxQmIofAfjvKaPeocYmTgYDzGqAFU+
        2rD6AqMUS15+XqqSCO/bOUIJQrwpiZVVqUX58UWlOanFhxilOViUxHnFHPkShATSE0tSs1NT
        C1KLYLJMHJxSDUwN72ac2H+m9q22qXOfsv7VY7fM9yp7s9omdSqUqB9dwXtOM0NAcH9Rkd3H
        hsVfv0ilVv/5c+j7qRXmFaEpRgfXtM8NF5UV+nViYfKWzeenyF78UmIT67Vt/ZrXQklrtUQq
        liacvHvZYqHCyyyrBLvSlyt+vf3IvsZQQJ15pWjqHWOhKUv6dj9Yq3X5vd+yF2FyLB2CEzL4
        5Je2PZl58cr35qN3Vj2WO/Nf/bHDhcVLlgVcuCfyd+Gk81ZWTj8bX/u8V+JzCEn7aca3f9qk
        L3qLCy9t3Zv4b5POewnVvAM/l2yecTPje/uedZqX3iyO7313w8bt+at7N7a3r9CYUiBiZrc0
        wlx+t5Gdp6fxK81Xc5RYijMSDbWYi4oTAUSPV18cAwAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/EexqPCuWxTsNhVXLba=9wVX
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 28 Jan 2021 09:43:52 -0800
"Luck, Tony" <tony.luck@intel.com> wrote:

> On Thu, Jan 28, 2021 at 07:43:26PM +0800, Aili Yao wrote:
> > when one page is already hwpoisoned by AO action, process may not be
> > killed, the process mapping this page may make a syscall include this
> > page and result to trigger a VM_FAULT_HWPOISON fault, as it's in kernel
> > mode it may be fixed by fixup_exception, current code will just return
> > error code to user process.  
> 
> Shouldn't the AO action that poisoned the page have also unmapped it?

Yes, The page has been unmapped in the code mm/rmap.c:

1567                 if (PageHWPoison(page) && !(flags & TTU_IGNORE_HWPOISON)) {
1568                         pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
1569                         if (PageHuge(page)) {
1570                                 hugetlb_count_sub(compound_nr(page), mm);
1571                                 set_huge_swap_pte_at(mm, address,
1572                                                      pvmw.pte, pteval,
1573                                                      vma_mmu_pagesize(vma));
1574                         } else {
1575                                 dec_mm_counter(mm, mm_counter(page));
1576                                 set_pte_at(mm, address, pvmw.pte, pteval);
1577                         }
1578 
1579                 }

The pte for this page of processes mapping it should be marked with SWP_HWPOISON.
But the process may not be informed and may continue with the address which has been
ummaped, Then accessing the content in the page will trigger a page fault.

Normally, it will hit the code in arch/x86/mm/fault.c:

 945 #ifdef CONFIG_MEMORY_FAILURE
 946         if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
 947                 struct task_struct *tsk = current;
 948                 unsigned lsb = 0;
 949 
 950                 pr_err(
 951         "MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
 952                         tsk->comm, tsk->pid, address);
 953                 if (fault & VM_FAULT_HWPOISON_LARGE)
 954                         lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
 955                 if (fault & VM_FAULT_HWPOISON)
 956                         lsb = PAGE_SHIFT;
 957                 force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb);
 958                 return;
 959         }
 960 #endif
 961         force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
 962 }

But when the user processes do a syscall and make a copyin action in kernel space, 
the page fault triggered by this action will not got the the above code, it actually
go to the code in arch/x86/mm/fault.c:

 650         if (fixup_exception(regs, X86_TRAP_PF, error_code, address)) {
 674                 /*
 675                  * Barring that, we can do the fixup and be happy.
 676                  */
 677                 return;
 678         }

> > 
> > This is not suffient, we should send a SIGBUS to the process and log the
> > info to console, as we can't trust the process will handle the error
> > correctly.  
> 
> I agree with this part ... few apps check for -EFAULT and do the right
> thing.  But I'm not sure how this happens. Can you provide a bit more
> detail on the steps
> 

Attachment is a simple code to test this, you can try this test with:
./einj_mem_uc -f copyin2

In my enviroment, the stack will be:

[ 1583.063050] Memory failure: 0x1030254: recovery action for dirty LRU page: Recovered
[ 1583.071724] MCE: Killing einj_mem_uc:11139 due to hardware memory corruption fault at 7f4d59032000
[ 1583.081732] CPU: 38 PID: 11139 Comm: einj_mem_uc Kdump: loaded Not tainted 5.11.0-rc2+ #43
[ 1583.102607] Call Trace:
[ 1583.105338]  dump_stack+0x57/0x6a
[ 1583.109041]  no_context.cold+0xf6/0x284
[ 1583.113315]  mm_fault_error+0xc3/0x1b0
[ 1583.117503]  exc_page_fault+0x57/0x110
[ 1583.121690]  asm_exc_page_fault+0x1e/0x30
[ 1583.126159] RIP: 0010:__get_user_nocheck_8+0x10/0x13
[ 1583.131704] Code: 0f b7 10 31 c0 0f 01 ca c3 90 0f 01 cb 0f ae e8 8b 10 31 c0 0f 01 ca c3 66 90 0f 01 cb 0f ae e8 48 8b 10 31 c0 0f 01 ca c3 90 <0f> 01 ca 31 d2 48 c7 c0 f2 ff ff ff c3 cc cc cc 0f 1f 44 00 00 40
[ 1583.152659] RSP: 0018:ffffb9e462917d90 EFLAGS: 00050293
[ 1583.158490] RAX: 00007f4d59032000 RBX: 0000000000000000 RCX: 00007f4d59032000
[ 1583.166453] RDX: 0000000000000000 RSI: 0000000000000200 RDI: 00007f4d590321ff
[ 1583.174418] RBP: 0000000000000200 R08: 0000000000000200 R09: ffffb9e462917e50
[ 1583.182382] R10: 0000000000000200 R11: 0000000000000000 R12: ffffb9e462917e60
[ 1583.190345] R13: ffff941470e93058 R14: 0000000000001000 R15: ffffffffc0626540
[ 1583.198310]  iov_iter_fault_in_readable+0x4f/0x120
[ 1583.203657]  generic_perform_write+0x83/0x1c0
[ 1583.208520]  ext4_buffered_write_iter+0x93/0x150 [ext4]
[ 1583.214378]  new_sync_write+0x11f/0x1b0
[ 1583.218661]  vfs_write+0x1c0/0x280
[ 1583.222455]  ksys_write+0x5f/0xe0
[ 1583.226153]  do_syscall_64+0x33/0x40
[ 1583.230142]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1583.235778] RIP: 0033:0x7f4d58b35cd0

> P.S. Typo: s/suffient/sufficient/

Thanks for correction!

-- 
Best Regards!

Aili Yao

--MP_/EexqPCuWxTsNhVXLba=9wVX
Content-Type: text/x-c++src
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="einj_mem_uc.c"

/*
 * Copyright (C) 2015 Intel Corporation
 * Author: Tony Luck
 *
 * This software may be redistributed and/or modified under the terms of
 * the GNU General Public License ("GPL") version 2 only as published by the
 * Free Software Foundation.
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <time.h>
#include <sys/mman.h>
#include <sys/time.h>
#include <setjmp.h>
#include <signal.h>
#define _GNU_SOURCE 1
#define __USE_GNU 1
#include <sched.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/prctl.h>
#include <setjmp.h>

extern long long vtop(long long);
extern void proc_cpuinfo(int *nsockets, int *ncpus, char *model, int **apicmap);
extern void proc_interrupts(long *nmce, long *ncmci);
extern void do_memcpy(void *dst, void *src, int cnt);
static void show_help(void);

static char *progname;
static int nsockets, ncpus, lcpus_persocket;
static int force_flag;
static int all_flag;
static long pagesize;
static int *apicmap;
#define	CACHE_LINE_SIZE	64

#define EINJ_ETYPE "/sys/kernel/debug/apei/einj/error_type"
#define EINJ_ADDR "/sys/kernel/debug/apei/einj/param1"
#define EINJ_MASK "/sys/kernel/debug/apei/einj/param2"
#define EINJ_APIC "/sys/kernel/debug/apei/einj/param3"
#define EINJ_FLAGS "/sys/kernel/debug/apei/einj/flags"
#define EINJ_NOTRIGGER "/sys/kernel/debug/apei/einj/notrigger"
#define EINJ_DOIT "/sys/kernel/debug/apei/einj/error_inject"

static void wfile(char *file, unsigned long long val)
{
	FILE *fp = fopen(file, "w");

	if (fp == NULL) {
		fprintf(stderr, "%s: cannot open '%s'\n", progname, file);
		exit(1);
	}
	fprintf(fp, "0x%llx\n", val);
	if (fclose(fp) == EOF) {
		fprintf(stderr, "%s: write error on '%s'\n", progname, file);
		exit(1);
	}
}

static void * copyin2_addr = NULL;
static void inject_madvise(unsigned long long page,int notrigger)
{
	if(copyin2_addr == NULL){
		printf("Invalid parameter \n");
		exit(0);
	}
	if (madvise(copyin2_addr, 100, 100) != 0) {
		if (errno == EINVAL) {
			printf("Kernel doesn't support poison injection\n");
			exit(0);
		}
		printf("madvise \n");
	}
}

static void inject_uc(unsigned long long addr, int notrigger)
{
	wfile(EINJ_ETYPE, 0x10);
	wfile(EINJ_ADDR, addr);
	wfile(EINJ_MASK, ~0x0ul);
	//wfile(EINJ_FLAGS, 2);
	wfile(EINJ_NOTRIGGER, notrigger);
	wfile(EINJ_DOIT, 1);
}

static void inject_llc(unsigned long long addr, int notrigger)
{
	unsigned cpu;

	cpu = sched_getcpu();
	wfile(EINJ_ETYPE, 0x2);
	wfile(EINJ_ADDR, addr);
	wfile(EINJ_MASK, ~0x0ul);
	wfile(EINJ_APIC, apicmap[cpu]);
	wfile(EINJ_FLAGS, 3);
	wfile(EINJ_NOTRIGGER, notrigger);
	wfile(EINJ_DOIT, 1);
}

static int is_advanced_ras(char *model)
{
	if (strstr(model, "E7-"))
		return 1;
	if (strstr(model, "Platinum"))
		return 1;
	if (strstr(model, "Gold"))
		return 1;
	return 0;
}

static void check_configuration(void)
{
	char	model[512];

	if (getuid() != 0) {
		fprintf(stderr, "%s: must be root to run error injection tests\n", progname);
		exit(1);
	}
	if (access("/sys/firmware/acpi/tables/EINJ", R_OK) == -1) {
		fprintf(stderr, "%s: Error injection not supported, check your BIOS settings\n", progname);
		exit(1);
	}
	if (access(EINJ_NOTRIGGER, R_OK|W_OK) == -1) {
		fprintf(stderr, "%s: Is the einj.ko module loaded?\n", progname);
		exit(1);
	}
	model[0] = '\0';
	proc_cpuinfo(&nsockets, &ncpus, model, &apicmap);
	if (nsockets == 0 || ncpus == 0) {
		fprintf(stderr, "%s: could not find number of sockets/cpus\n", progname);
		exit(1);
	}
	if (ncpus % nsockets) {
		fprintf(stderr, "%s: strange topology. Are all cpus online?\n", progname);
		exit(1);
	}
	lcpus_persocket = ncpus / nsockets;
	if (!force_flag && !is_advanced_ras(model)) {
		fprintf(stderr, "%s: warning: cpu may not support recovery\n", progname);
		exit(1);
	}
}

#define REP9(stmt) stmt;stmt;stmt;stmt;stmt;stmt;stmt;stmt;stmt

volatile int vol;

int dosums(void)
{
	vol = 0;
	REP9(REP9(REP9(vol++)));
	return vol;
}

#define MB(n)	((n) * 1024 * 1024)

static void *thp_data_alloc(void)
{
	char	*p = malloc(MB(128));
	int	i;

	if (p == NULL) {
		fprintf(stderr, "%s: cannot allocate memory\n", progname);
		exit(1);
	}
	srandom(getpid() * time(NULL));
	for (i = 0; i < MB(128); i++)
		p[i] = random();
	return p + MB(64);
}

static void *data_alloc(void)
{
	char	*p = mmap(NULL, pagesize, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANON, -1, 0);
	int	i;

	if (p == NULL) {
		fprintf(stderr, "%s: cannot allocate memory\n", progname);
		exit(1);
	}
	srandom(getpid() * time(NULL));
	for (i = 0; i < pagesize; i++)
		p[i] = random();
	return p + pagesize / 4;
}
static void *data_alloc_copyin2(void)
{
        char    *p = mmap(NULL, pagesize, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANON, -1, 0);
        int     i;

        if (p == NULL) {
                fprintf(stderr, "%s: cannot allocate memory\n", progname);
                exit(1);
        }
        srandom(getpid() * time(NULL));
        for (i = 0; i < pagesize; i++)
                p[i] = random();

		copyin2_addr = p;
        return p;
}

static FILE *pcfile;

static void *page_cache_alloc(void)
{
	char c, *p;
	int i;

	pcfile = tmpfile();
	for (i = 0; i < pagesize; i++) {
		c = random();
		fputc(c, pcfile);
	}
	fflush(pcfile);

	p = mmap(NULL, pagesize, PROT_READ|PROT_WRITE, MAP_SHARED, fileno(pcfile), 0);
	if (p == NULL) {
		fprintf(stderr, "%s: cannot mmap tmpfile\n", progname);
		exit(1);
	}
	*p = random();

	return p + pagesize / 4;
}

static void *mlock_data_alloc(void)
{
	char	*p = mmap(NULL, pagesize, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANON, -1, 0);
	int	i;

	if (p == NULL) {
		fprintf(stderr, "%s: cannot allocate memory\n", progname);
		exit(1);
	}
	srandom(getpid() * time(NULL));
	for (i = 0; i < pagesize; i++)
		p[i] = random();
	if (mlock(p, pagesize) == -1) {
		fprintf(stderr, "%s: cannot mlock(2) memory\n", progname);
		exit(1);
	}
	return p + pagesize / 4;
}

static void *instr_alloc(void)
{
	char	*p = (char *)dosums;

	p += 2 * pagesize;

	return (void *)((long)p & ~(pagesize - 1));
}

int trigger_single(char *addr)
{
	return addr[0];
}

int trigger_double(char *addr)
{
	return addr[0] + addr[1];
}

int trigger_split(char *addr)
{
	long *a = (long *)(addr - 1);

	return a[0];
}

int trigger_write(char *addr)
{
	addr[0] = 'a';
	return 0;
}

/*
 * parameters to the memcpy and copyin tests.
 */
int memcpy_runup = 0;	/* how much to copy before hitting poison */
int memcpy_size = 512;	/* Total amount to copy */
int memcpy_align = 0;	/* Relative alignment of src/dst */

/* argument is "runup:size:align" */
void parse_memcpy(char *arg)
{
	char *endp;

	memcpy_runup = strtol(arg, &endp, 0);
	if (*endp != ':')
		show_help();
	memcpy_size = strtol(endp + 1, &endp, 0);
	if (*endp != ':')
		show_help();
	memcpy_align = strtol(endp + 1, &endp, 0);
	if (*endp != '\0')
		show_help();
	if (memcpy_runup < 0 || memcpy_runup > pagesize / 4) {
		fprintf(stderr, "%s: runup out of range\n", progname);
		exit(1);
	}
	if (memcpy_size < 0 || memcpy_size > pagesize / 4) {
		fprintf(stderr, "%s: size out of range\n", progname);
		exit(1);
	}
	if (memcpy_runup > memcpy_size) {
		fprintf(stderr, "%s: runup must be less than size\n", progname);
		exit(1);
	}
	if (memcpy_align < 0 || memcpy_align >= CACHE_LINE_SIZE) {
		fprintf(stderr, "%s: bad alignment\n", progname);
		exit(1);
	}
}

int trigger_memcpy(char *addr)
{
	char *src = addr - memcpy_runup;
	char *dst = addr + pagesize / 2;

	dst -= memcpy_align;
	do_memcpy(dst, src, memcpy_size);
	return 0;
}

int trigger_copyin(char *addr)
{
	int	fd, ret;
	char	filename[] = "/tmp/einj-XXXXXX";

	if ((fd = mkstemp(filename)) == -1) {
		fprintf(stderr, "%s: couldn't make temp file\n", progname);
		return -1;
	}
	(void)unlink(filename);
	if ((ret = write(fd, addr - memcpy_runup, memcpy_size) != memcpy_size)) {
		if (ret == -1)
			fprintf(stderr, "%s: couldn't write temp file (errno=%d)\n", progname, errno);
		else
			fprintf(stderr, "%s: short (%d bytes) write to temp file\n", ret, progname);
	}
	close(fd);
	return 0;
}

int trigger_copyout(char *addr)
{
	char *buf = malloc(pagesize);
	int ret;

	if (buf == NULL) {
		fprintf(stderr, "%s: couldn't allocate memory\n", progname);
		return -1;
	}
	rewind(pcfile);
	ret = fread(buf, 1, pagesize, pcfile);
	fprintf(stderr, "%s: read returned %d\n", progname);

	return 0;
}

int trigger_patrol(char *addr)
{
	sleep(1);
}

int trigger_llc(char *addr)
{
	asm volatile("clflush %0" : "+m" (*addr));
}

int trigger_instr(char *addr)
{
	int ret = dosums();

	if (ret != 729)
		printf("Corruption during instruction fault recovery (%d)\n", ret);

	return ret;
}

/* attributes of the test and which events will follow our trigger */
#define	F_MCE		1
#define	F_CMCI		2
#define F_SIGBUS	4
#define	F_FATAL		8

struct test {
	char	*testname;
	char	*testhelp;
	void	*(*alloc)(void);
	void	(*inject)(unsigned long long, int);
	int	notrigger;
	int	(*trigger)(char *);
	int	flags;
} tests[] = {
	{
		"single", "Single read in pipeline to target address, generates SRAR machine check",
		data_alloc, inject_uc, 1, trigger_single, F_MCE|F_CMCI|F_SIGBUS,
	},
	{
		"double", "Double read in pipeline to target address, generates SRAR machine check",
		data_alloc, inject_uc, 1, trigger_double, F_MCE|F_CMCI|F_SIGBUS,
	},
	{
		"split", "Unaligned read crosses cacheline from good to bad. Probably fatal",
		data_alloc, inject_uc, 1, trigger_split, F_MCE|F_CMCI|F_SIGBUS|F_FATAL,
	},
	{
		"THP", "Try to inject in transparent huge page, generates SRAR machine check",
		thp_data_alloc, inject_uc, 1, trigger_single, F_MCE|F_CMCI|F_SIGBUS,
	},
	{
		"store", "Write to target address. Should generate a UCNA/CMCI",
		data_alloc, inject_uc, 1, trigger_write, F_CMCI,
	},
	{
		"memcpy", "Streaming read from target address. Probably fatal",
		data_alloc, inject_uc, 1, trigger_memcpy, F_MCE|F_CMCI|F_SIGBUS|F_FATAL,
	},
	{
		"instr", "Instruction fetch. Generates SRAR that OS should transparently fix",
		instr_alloc, inject_uc, 1, trigger_instr, F_MCE|F_CMCI,
	},
	{
		"patrol", "Patrol scrubber, generates SRAO machine check",
		data_alloc, inject_uc, 0, trigger_patrol, F_MCE,
	},
	{
		"llc", "Cache write-back, generates SRAO machine check",
		data_alloc, inject_llc, 1, trigger_llc, F_MCE,
	},
	{
		"copyin", "Kernel copies data from user. Probably fatal",
		data_alloc, inject_uc, 1, trigger_copyin, F_MCE|F_CMCI|F_SIGBUS|F_FATAL,
	},
	{
		"copyin2", "Recover form Kernel copies data from user, user page already poisoned!",
		data_alloc_copyin2, inject_madvise, 1, trigger_copyin, F_MCE|F_SIGBUS,
	},
	{
		"copyout", "Kernel copies data to user. Probably fatal",
		page_cache_alloc, inject_uc, 1, trigger_copyout, F_MCE|F_SIGBUS|F_CMCI|F_FATAL,
	},
	{
		"mlock", "mlock target page then inject/read to generates SRAR machine check",
		mlock_data_alloc, inject_uc, 1, trigger_single, F_MCE|F_CMCI|F_SIGBUS,
	},
	{ NULL }
};

static void show_help(void)
{
	struct test *t;

	printf("Usage: %s [-a][-c count][-d delay][-f] [-m runup:size:align][testname]\n", progname);
	printf("  %-8s %-5s %s\n", "Testname", "Fatal", "Description");
	for (t = tests; t->testname; t++)
		printf("  %-8s %-5s %s\n", t->testname,
			(t->flags & F_FATAL) ? "YES" : "no",
			t->testhelp);
	exit(0);
}

static struct test *lookup_test(char *s)
{
	struct test *t;

	for (t = tests; t->testname; t++)
		if (strcmp(s, t->testname) == 0)
			return t;
	fprintf(stderr, "%s: unknown test '%s'\n", progname, s);
	exit(1);
}

static struct test *next_test(struct test *t)
{
	t++;
	if (t->testname == NULL)
		t = tests;
	return t;
}

static jmp_buf env;

static void recover(int sig, siginfo_t *si, void *v)
{
	printf("SIGBUS: addr = %p\n", si->si_addr);
	siglongjmp(env, 1);
}

struct sigaction recover_act = {
	.sa_sigaction = recover,
	.sa_flags = SA_SIGINFO,
};

int main(int argc, char **argv)
{
	int c, i;
	int	count = 1, cmci_wait_count = 0;
	double	delay = 1.0;
	struct test *t;
	void	*vaddr;
	long long paddr;
	long	b_mce, b_cmci, a_mce, a_cmci;
	struct timeval t1, t2;

	progname = argv[0];
	pagesize = getpagesize();

	while ((c = getopt(argc, argv, "ac:d:fhm:")) != -1) switch (c) {
	case 'a':
		all_flag = 1;
		break;
	case 'c':
		count = strtol(optarg, NULL, 0);
		break;
	case 'd':
		delay = strtod(optarg, NULL);
		break;
	case 'f':
		force_flag = 1;
		break;
	case 'm':
		parse_memcpy(optarg);
		break;
	case 'h': case '?':
		show_help();
		break;
	}

	check_configuration();

	if (optind < argc)
		t = lookup_test(argv[optind]);
	else
		t = tests;

	if ((t->flags & F_FATAL) && !force_flag) {
		fprintf(stderr, "%s: selected test may be fatal. Use '-f' flag if you really want to do this\n", progname);
		exit(1);
	}

	sigaction(SIGBUS, &recover_act, NULL);

	for (i = 0; i < count; i++) {
		cmci_wait_count = 0;
		vaddr = t->alloc();
		paddr = vtop((long long)vaddr);
		printf("%d: %-8s vaddr = %p paddr = %llx\n", i, t->testname, vaddr, paddr);

		proc_interrupts(&b_mce, &b_cmci);
		gettimeofday(&t1, NULL);
		if (sigsetjmp(env, 1)) {
			if ((t->flags & F_SIGBUS) == 0) {
				printf("Unexpected SIGBUS\n");
			}
		} else {
			t->inject(paddr, t->notrigger);
			t->trigger(vaddr);
			if (t->flags & F_SIGBUS) {
				printf("Expected SIGBUS, didn't get one\n");
			}
		}

		if (pcfile) {
			fclose(pcfile);
			pcfile = NULL;
		}

		/* if system didn't already take page offline, ask it to do so now */
		if (paddr == vtop((long long)vaddr)) {
			printf("Manually take page offline\n");
			wfile("/sys/devices/system/memory/hard_offline_page", paddr);
		}

		/* Give system a chance to process on possibly deep C-state idle cpus */
		usleep(100);

		proc_interrupts(&a_mce, &a_cmci);

		if (t->flags & F_FATAL) {
			printf("Big surprise ... still running. Thought that would be fatal\n");
		}

		if (t->flags & F_MCE) {
			if (a_mce == b_mce) {
				printf("Expected MCE, but none seen\n");
			} else if (a_mce == b_mce + 1) {
				printf("Saw local machine check\n");
			} else if (a_mce == b_mce + ncpus) {
				printf("Saw broadcast machine check\n");
			} else {
				printf("Unusual number of MCEs seen: %ld\n", a_mce - b_mce);
			}
		} else {
			if (a_mce != b_mce) {
				printf("Saw %ld unexpected MCEs (%ld systemwide)\n", b_mce - a_mce, (b_mce - a_mce) / ncpus);
			}
		}

		if (t->flags & F_CMCI) {
			while (a_cmci < b_cmci + lcpus_persocket) {
				if (cmci_wait_count > 1000) {
					break;
				}
				usleep(100);
				proc_interrupts(&a_mce, &a_cmci);
				cmci_wait_count++;
			}
			if (cmci_wait_count != 0) {
				gettimeofday(&t2, NULL);
				printf("CMCIs took ~%ld usecs to be reported.\n",
					1000000 * (t2.tv_sec - t1.tv_sec) +
						(t2.tv_usec - t1.tv_usec));
			}
			if (a_cmci == b_cmci) {
				printf("Expected CMCI, but none seen\n");
				printf("Test failed\n");
				return 1;
			} else if (a_cmci < b_cmci + lcpus_persocket) {
				printf("Unusual number of CMCIs seen: %ld\n", a_cmci - b_cmci);
				printf("Test failed\n");
				return 1;
			}
		} else {
			if (a_cmci != b_cmci) {
				printf("Saw %ld unexpected CMCIs (%ld per socket)\n", a_cmci - b_cmci, (a_cmci - b_cmci) / lcpus_persocket);
				printf("Test failed\n");
				return 1;
			}
		}

		usleep((useconds_t)(delay * 1.0e6));
		if (all_flag) {
			t = next_test(t);
			while (t->flags & F_FATAL)
				t = next_test(t);
		}
	}

	printf("Test passed\n");
	return 0;
}

--MP_/EexqPCuWxTsNhVXLba=9wVX--
