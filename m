Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A873BAEEE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 22:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhGDUb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 16:31:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229919AbhGDUb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 16:31:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AF32613F6;
        Sun,  4 Jul 2021 20:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625430560;
        bh=TMKitkLOdrQTJn04A3xkuM0vqFyuFYMyLh3SE1KizmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fCYL/r9ukFWmN1uAMr8sXonhfHwk73jUYyjZbHMpUi5tjkGsorx3HiNtbYXiYPETI
         +ozQiwj0kMZsfkrZQanGFXUA/+q3w3/dR3E32CZiVJckrBU7pv8Hdr8cAk/52yzn0u
         l3ug5dkXWk0grdXzFe9nhG95KtAAJhkSGUuNjvEnVgPps54TSfggizwc6jD7iWEXCr
         ymvj2F3J64LySPmfbe7HGSpwrLaoFCL7BKMqrm3ItrURPuZsTIV7ILjXRZCk0EuCef
         +adq71u6ScbQAUWy+QsxPjaUF0Z49sNeydrdNZVZMqKi0D9Z9cdTka9yf7G0ZhV9v0
         EsXrwXkzaWJoQ==
From:   ojeda@kernel.org
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Fox Chen <foxhlchen@gmail.com>,
        Ayaan Zaidi <zaidi.ayaan@gmail.com>,
        Douglas Su <d0u9.su@outlook.com>, Yuki Okushi <jtitor@2k36.org>
Subject: [PATCH 10/17] rust: add `kernel` crate
Date:   Sun,  4 Jul 2021 22:27:49 +0200
Message-Id: <20210704202756.29107-11-ojeda@kernel.org>
In-Reply-To: <20210704202756.29107-1-ojeda@kernel.org>
References: <20210704202756.29107-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miguel Ojeda <ojeda@kernel.org>

The `kernel` crate currently includes all the abstractions that wrap
kernel features written in C.

These abstractions call the C side of the kernel via the generated
bindings with the `bindgen` tool. Modules developed in Rust should
never call the bindings themselves.

In the future, as the abstractions grow in number, we may need
to split this crate into several, possibly following a similar
subdivision in subsystems as the kernel itself.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Geoffrey Thomas <geofft@ldpreload.com>
Signed-off-by: Geoffrey Thomas <geofft@ldpreload.com>
Co-developed-by: Finn Behrens <me@kloenk.de>
Signed-off-by: Finn Behrens <me@kloenk.de>
Co-developed-by: Adam Bratschi-Kaye <ark.email@gmail.com>
Signed-off-by: Adam Bratschi-Kaye <ark.email@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Co-developed-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
Co-developed-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Co-developed-by: Sven Van Asbroeck <thesven73@gmail.com>
Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Boris-Chengbiao Zhou <bobo1239@web.de>
Signed-off-by: Boris-Chengbiao Zhou <bobo1239@web.de>
Co-developed-by: Fox Chen <foxhlchen@gmail.com>
Signed-off-by: Fox Chen <foxhlchen@gmail.com>
Co-developed-by: Ayaan Zaidi <zaidi.ayaan@gmail.com>
Signed-off-by: Ayaan Zaidi <zaidi.ayaan@gmail.com>
Co-developed-by: Douglas Su <d0u9.su@outlook.com>
Signed-off-by: Douglas Su <d0u9.su@outlook.com>
Co-developed-by: Yuki Okushi <jtitor@2k36.org>
Signed-off-by: Yuki Okushi <jtitor@2k36.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 include/linux/spinlock.h       |  17 +-
 kernel/printk/printk.c         |   5 +-
 rust/kernel/allocator.rs       |  63 +++
 rust/kernel/bindings.rs        |  28 ++
 rust/kernel/bindings_helper.h  |  24 ++
 rust/kernel/buffer.rs          |  39 ++
 rust/kernel/build_assert.rs    |  80 ++++
 rust/kernel/c_types.rs         | 119 ++++++
 rust/kernel/chrdev.rs          | 212 ++++++++++
 rust/kernel/error.rs           | 272 +++++++++++++
 rust/kernel/file.rs            | 130 ++++++
 rust/kernel/file_operations.rs | 698 +++++++++++++++++++++++++++++++++
 rust/kernel/io_buffer.rs       | 153 ++++++++
 rust/kernel/iov_iter.rs        |  95 +++++
 rust/kernel/lib.rs             | 220 +++++++++++
 rust/kernel/linked_list.rs     | 245 ++++++++++++
 rust/kernel/miscdev.rs         | 113 ++++++
 rust/kernel/module_param.rs    | 497 +++++++++++++++++++++++
 rust/kernel/of.rs              | 101 +++++
 rust/kernel/pages.rs           | 176 +++++++++
 rust/kernel/platdev.rs         | 166 ++++++++
 rust/kernel/prelude.rs         |  28 ++
 rust/kernel/print.rs           | 412 +++++++++++++++++++
 rust/kernel/random.rs          |  50 +++
 rust/kernel/raw_list.rs        | 361 +++++++++++++++++
 rust/kernel/rbtree.rs          | 570 +++++++++++++++++++++++++++
 rust/kernel/security.rs        |  79 ++++
 rust/kernel/static_assert.rs   |  39 ++
 rust/kernel/str.rs             | 259 ++++++++++++
 rust/kernel/sync/arc.rs        | 227 +++++++++++
 rust/kernel/sync/condvar.rs    | 136 +++++++
 rust/kernel/sync/guard.rs      |  82 ++++
 rust/kernel/sync/locked_by.rs  | 112 ++++++
 rust/kernel/sync/mod.rs        |  84 ++++
 rust/kernel/sync/mutex.rs      | 101 +++++
 rust/kernel/sync/spinlock.rs   | 109 +++++
 rust/kernel/sysctl.rs          | 198 ++++++++++
 rust/kernel/task.rs            | 193 +++++++++
 rust/kernel/traits.rs          |  26 ++
 rust/kernel/types.rs           | 249 ++++++++++++
 rust/kernel/user_ptr.rs        | 191 +++++++++
 41 files changed, 6952 insertions(+), 7 deletions(-)
 create mode 100644 rust/kernel/allocator.rs
 create mode 100644 rust/kernel/bindings.rs
 create mode 100644 rust/kernel/bindings_helper.h
 create mode 100644 rust/kernel/buffer.rs
 create mode 100644 rust/kernel/build_assert.rs
 create mode 100644 rust/kernel/c_types.rs
 create mode 100644 rust/kernel/chrdev.rs
 create mode 100644 rust/kernel/error.rs
 create mode 100644 rust/kernel/file.rs
 create mode 100644 rust/kernel/file_operations.rs
 create mode 100644 rust/kernel/io_buffer.rs
 create mode 100644 rust/kernel/iov_iter.rs
 create mode 100644 rust/kernel/lib.rs
 create mode 100644 rust/kernel/linked_list.rs
 create mode 100644 rust/kernel/miscdev.rs
 create mode 100644 rust/kernel/module_param.rs
 create mode 100644 rust/kernel/of.rs
 create mode 100644 rust/kernel/pages.rs
 create mode 100644 rust/kernel/platdev.rs
 create mode 100644 rust/kernel/prelude.rs
 create mode 100644 rust/kernel/print.rs
 create mode 100644 rust/kernel/random.rs
 create mode 100644 rust/kernel/raw_list.rs
 create mode 100644 rust/kernel/rbtree.rs
 create mode 100644 rust/kernel/security.rs
 create mode 100644 rust/kernel/static_assert.rs
 create mode 100644 rust/kernel/str.rs
 create mode 100644 rust/kernel/sync/arc.rs
 create mode 100644 rust/kernel/sync/condvar.rs
 create mode 100644 rust/kernel/sync/guard.rs
 create mode 100644 rust/kernel/sync/locked_by.rs
 create mode 100644 rust/kernel/sync/mod.rs
 create mode 100644 rust/kernel/sync/mutex.rs
 create mode 100644 rust/kernel/sync/spinlock.rs
 create mode 100644 rust/kernel/sysctl.rs
 create mode 100644 rust/kernel/task.rs
 create mode 100644 rust/kernel/traits.rs
 create mode 100644 rust/kernel/types.rs
 create mode 100644 rust/kernel/user_ptr.rs

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 79897841a2c..a022992725b 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -331,12 +331,17 @@ static __always_inline raw_spinlock_t *spinlock_check(spinlock_t *lock)
 
 #ifdef CONFIG_DEBUG_SPINLOCK
 
-# define spin_lock_init(lock)					\
-do {								\
-	static struct lock_class_key __key;			\
-								\
-	__raw_spin_lock_init(spinlock_check(lock),		\
-			     #lock, &__key, LD_WAIT_CONFIG);	\
+static inline void __spin_lock_init(spinlock_t *lock, const char *name,
+				    struct lock_class_key *key)
+{
+	__raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
+}
+
+# define spin_lock_init(lock)			\
+do {						\
+	static struct lock_class_key __key;	\
+						\
+	__spin_lock_init(lock, #lock, &__key);	\
 } while (0)
 
 #else
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 421c3557179..f7f6d13476d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -397,7 +397,10 @@ static struct latched_seq clear_seq = {
 /* the maximum size of a formatted record (i.e. with prefix added per line) */
 #define CONSOLE_LOG_MAX		1024
 
-/* the maximum size allowed to be reserved for a record */
+/*
+ * The maximum size allowed to be reserved for a record.
+ * Keep in sync with rust/kernel/print.rs.
+ */
 #define LOG_LINE_MAX		(CONSOLE_LOG_MAX - PREFIX_MAX)
 
 #define LOG_LEVEL(v)		((v) & 0x07)
diff --git a/rust/kernel/allocator.rs b/rust/kernel/allocator.rs
new file mode 100644
index 00000000000..759cec47de2
--- /dev/null
+++ b/rust/kernel/allocator.rs
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Allocator support.
+
+use core::alloc::{GlobalAlloc, Layout};
+use core::ptr;
+
+use crate::bindings;
+use crate::c_types;
+
+pub struct KernelAllocator;
+
+unsafe impl GlobalAlloc for KernelAllocator {
+    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
+        // `krealloc()` is used instead of `kmalloc()` because the latter is
+        // an inline function and cannot be bound to as a result.
+        unsafe { bindings::krealloc(ptr::null(), layout.size(), bindings::GFP_KERNEL) as *mut u8 }
+    }
+
+    unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
+        unsafe {
+            bindings::kfree(ptr as *const c_types::c_void);
+        }
+    }
+}
+
+#[global_allocator]
+static ALLOCATOR: KernelAllocator = KernelAllocator;
+
+// `rustc` only generates these for some crate types. Even then, we would need
+// to extract the object file that has them from the archive. For the moment,
+// let's generate them ourselves instead.
+#[no_mangle]
+pub fn __rust_alloc(size: usize, _align: usize) -> *mut u8 {
+    unsafe { bindings::krealloc(core::ptr::null(), size, bindings::GFP_KERNEL) as *mut u8 }
+}
+
+#[no_mangle]
+pub fn __rust_dealloc(ptr: *mut u8, _size: usize, _align: usize) {
+    unsafe { bindings::kfree(ptr as *const c_types::c_void) };
+}
+
+#[no_mangle]
+pub fn __rust_realloc(ptr: *mut u8, _old_size: usize, _align: usize, new_size: usize) -> *mut u8 {
+    unsafe {
+        bindings::krealloc(
+            ptr as *const c_types::c_void,
+            new_size,
+            bindings::GFP_KERNEL,
+        ) as *mut u8
+    }
+}
+
+#[no_mangle]
+pub fn __rust_alloc_zeroed(size: usize, _align: usize) -> *mut u8 {
+    unsafe {
+        bindings::krealloc(
+            core::ptr::null(),
+            size,
+            bindings::GFP_KERNEL | bindings::__GFP_ZERO,
+        ) as *mut u8
+    }
+}
diff --git a/rust/kernel/bindings.rs b/rust/kernel/bindings.rs
new file mode 100644
index 00000000000..93290926cec
--- /dev/null
+++ b/rust/kernel/bindings.rs
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Bindings
+//!
+//! Imports the generated bindings by `bindgen`.
+
+// See https://github.com/rust-lang/rust-bindgen/issues/1651.
+#![cfg_attr(test, allow(deref_nullptr))]
+#![cfg_attr(test, allow(unaligned_references))]
+#![cfg_attr(test, allow(unsafe_op_in_unsafe_fn))]
+
+#[allow(
+    clippy::all,
+    non_camel_case_types,
+    non_upper_case_globals,
+    non_snake_case,
+    improper_ctypes,
+    unsafe_op_in_unsafe_fn
+)]
+mod bindings_raw {
+    use crate::c_types;
+    include!(env!("RUST_BINDINGS_FILE"));
+}
+pub use bindings_raw::*;
+
+pub const GFP_KERNEL: gfp_t = BINDINGS_GFP_KERNEL;
+pub const __GFP_ZERO: gfp_t = BINDINGS___GFP_ZERO;
+pub const __GFP_HIGHMEM: gfp_t = ___GFP_HIGHMEM;
diff --git a/rust/kernel/bindings_helper.h b/rust/kernel/bindings_helper.h
new file mode 100644
index 00000000000..c64a6307da3
--- /dev/null
+++ b/rust/kernel/bindings_helper.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/cdev.h>
+#include <linux/errname.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/random.h>
+#include <linux/slab.h>
+#include <linux/sysctl.h>
+#include <linux/uaccess.h>
+#include <linux/uio.h>
+#include <linux/version.h>
+#include <linux/miscdevice.h>
+#include <linux/poll.h>
+#include <linux/mm.h>
+#include <linux/file.h>
+#include <uapi/linux/android/binder.h>
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/security.h>
+
+// `bindgen` gets confused at certain things
+const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
+const gfp_t BINDINGS___GFP_ZERO = __GFP_ZERO;
diff --git a/rust/kernel/buffer.rs b/rust/kernel/buffer.rs
new file mode 100644
index 00000000000..b2502fa968f
--- /dev/null
+++ b/rust/kernel/buffer.rs
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Struct for writing to a pre-allocated buffer with the [`write!`] macro.
+
+use core::fmt;
+
+/// A pre-allocated buffer that implements [`core::fmt::Write`].
+///
+/// Consecutive writes will append to what has already been written.
+/// Writes that don't fit in the buffer will fail.
+pub struct Buffer<'a> {
+    slice: &'a mut [u8],
+    pos: usize,
+}
+
+impl<'a> Buffer<'a> {
+    /// Create a new buffer from an existing array.
+    pub fn new(slice: &'a mut [u8]) -> Self {
+        Buffer { slice, pos: 0 }
+    }
+
+    /// Number of bytes that have already been written to the buffer.
+    /// This will always be less than the length of the original array.
+    pub fn bytes_written(&self) -> usize {
+        self.pos
+    }
+}
+
+impl<'a> fmt::Write for Buffer<'a> {
+    fn write_str(&mut self, s: &str) -> fmt::Result {
+        if s.len() > self.slice.len() - self.pos {
+            Err(fmt::Error)
+        } else {
+            self.slice[self.pos..self.pos + s.len()].copy_from_slice(s.as_bytes());
+            self.pos += s.len();
+            Ok(())
+        }
+    }
+}
diff --git a/rust/kernel/build_assert.rs b/rust/kernel/build_assert.rs
new file mode 100644
index 00000000000..f726927185c
--- /dev/null
+++ b/rust/kernel/build_assert.rs
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Build-time assert.
+
+/// Fails the build if the code path calling `build_error!` can possibly be executed.
+///
+/// If the macro is executed in const context, `build_error!` will panic.
+/// If the compiler or optimizer cannot guarantee that `build_error!` can never
+/// be called, a build error will be triggered.
+///
+/// # Examples
+/// ```
+/// # use kernel::build_error;
+/// #[inline]
+/// fn foo(a: usize) -> usize {
+///     a.checked_add(1).unwrap_or_else(|| build_error!("overflow"))
+/// }
+/// ```
+#[macro_export]
+macro_rules! build_error {
+    () => {{
+        $crate::build_error("")
+    }};
+    ($msg:expr) => {{
+        $crate::build_error($msg)
+    }};
+}
+
+/// Asserts that a boolean expression is `true` at compile time.
+///
+/// If the condition is evaluated to `false` in const context, `build_assert!`
+/// will panic. If the compiler or optimizer cannot guarantee the condition will
+/// be evaluated to `true`, a build error will be triggered.
+///
+/// [`static_assert!`] should be preferred to `build_assert!` whenever possible.
+///
+/// # Examples
+///
+/// These examples show that different types of [`assert!`] will trigger errors
+/// at different stage of compilation. It is preferred to err as early as
+/// possible, so [`static_assert!`] should be used whenever possible.
+/// ```compile_fail
+/// # use kernel::prelude::*;
+/// fn foo() {
+///     static_assert!(1 > 1); // Compile-time error
+///     build_assert!(1 > 1); // Build-time error
+///     assert!(1 > 1); // Run-time error
+/// }
+/// ```
+///
+/// When the condition refers to generic parameters or parameters of an inline function,
+/// [`static_assert!`] cannot be used. Use `build_assert!` in this scenario.
+/// ```no_run
+/// # use kernel::prelude::*;
+/// fn foo<const N: usize>() {
+///     // `static_assert!(N > 1);` is not allowed
+///     build_assert!(N > 1); // Build-time check
+///     assert!(N > 1); // Run-time check
+/// }
+///
+/// #[inline]
+/// fn bar(n: usize) {
+///     // `static_assert!(n > 1);` is not allowed
+///     build_assert!(n > 1); // Build-time check
+///     assert!(n > 1); // Run-time check
+/// }
+/// ```
+#[macro_export]
+macro_rules! build_assert {
+    ($cond:expr $(,)?) => {{
+        if !$cond {
+            $crate::build_error(concat!("assertion failed: ", stringify!($cond)));
+        }
+    }};
+    ($cond:expr, $msg:expr) => {{
+        if !$cond {
+            $crate::build_error($msg);
+        }
+    }};
+}
diff --git a/rust/kernel/c_types.rs b/rust/kernel/c_types.rs
new file mode 100644
index 00000000000..07593a3ba8b
--- /dev/null
+++ b/rust/kernel/c_types.rs
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! C types for the bindings.
+//!
+//! The bindings generated by `bindgen` use these types to map to the C ones.
+//!
+//! C's standard integer types may differ in width depending on
+//! the architecture, thus we need to conditionally compile those.
+
+#![allow(non_camel_case_types)]
+
+#[cfg(any(target_arch = "arm", target_arch = "x86", target_arch = "riscv32",))]
+mod c {
+    /// C `void` type.
+    pub type c_void = core::ffi::c_void;
+
+    /// C `char` type.
+    pub type c_char = i8;
+
+    /// C `signed char` type.
+    pub type c_schar = i8;
+
+    /// C `unsigned char` type.
+    pub type c_uchar = u8;
+
+    /// C `short` type.
+    pub type c_short = i16;
+
+    /// C `unsigned short` type.
+    pub type c_ushort = u16;
+
+    /// C `int` type.
+    pub type c_int = i32;
+
+    /// C `unsigned int` type.
+    pub type c_uint = u32;
+
+    /// C `long` type.
+    pub type c_long = i32;
+
+    /// C `unsigned long` type.
+    pub type c_ulong = u32;
+
+    /// C `long long` type.
+    pub type c_longlong = i64;
+
+    /// C `unsigned long long` type.
+    pub type c_ulonglong = u64;
+
+    /// C `ssize_t` type (typically defined in `<sys/types.h>` by POSIX).
+    ///
+    /// For some 32-bit architectures like this one, the kernel defines it as
+    /// `int`, i.e. it is an [`i32`].
+    pub type c_ssize_t = isize;
+
+    /// C `size_t` type (typically defined in `<stddef.h>`).
+    ///
+    /// For some 32-bit architectures like this one, the kernel defines it as
+    /// `unsigned int`, i.e. it is an [`u32`].
+    pub type c_size_t = usize;
+}
+
+#[cfg(any(
+    target_arch = "aarch64",
+    target_arch = "x86_64",
+    target_arch = "powerpc64",
+    target_arch = "riscv64",
+))]
+mod c {
+    /// C `void` type.
+    pub type c_void = core::ffi::c_void;
+
+    /// C `char` type.
+    pub type c_char = i8;
+
+    /// C `signed char` type.
+    pub type c_schar = i8;
+
+    /// C `unsigned char` type.
+    pub type c_uchar = u8;
+
+    /// C `short` type.
+    pub type c_short = i16;
+
+    /// C `unsigned short` type.
+    pub type c_ushort = u16;
+
+    /// C `int` type.
+    pub type c_int = i32;
+
+    /// C `unsigned int` type.
+    pub type c_uint = u32;
+
+    /// C `long` type.
+    pub type c_long = i64;
+
+    /// C `unsigned long` type.
+    pub type c_ulong = u64;
+
+    /// C `long long` type.
+    pub type c_longlong = i64;
+
+    /// C `unsigned long long` type.
+    pub type c_ulonglong = u64;
+
+    /// C `ssize_t` type (typically defined in `<sys/types.h>` by POSIX).
+    ///
+    /// For 64-bit architectures like this one, the kernel defines it as
+    /// `long`, i.e. it is an [`i64`].
+    pub type c_ssize_t = isize;
+
+    /// C `size_t` type (typically defined in `<stddef.h>`).
+    ///
+    /// For 64-bit architectures like this one, the kernel defines it as
+    /// `unsigned long`, i.e. it is an [`u64`].
+    pub type c_size_t = usize;
+}
+
+pub use c::*;
diff --git a/rust/kernel/chrdev.rs b/rust/kernel/chrdev.rs
new file mode 100644
index 00000000000..20e93ec05de
--- /dev/null
+++ b/rust/kernel/chrdev.rs
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Character devices.
+//!
+//! Also called "char devices", `chrdev`, `cdev`.
+//!
+//! C header: [`include/linux/cdev.h`](../../../../include/linux/cdev.h)
+//!
+//! Reference: <https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#char-devices>
+
+use alloc::boxed::Box;
+use core::convert::TryInto;
+use core::marker::PhantomPinned;
+use core::pin::Pin;
+
+use crate::bindings;
+use crate::c_types;
+use crate::error::{Error, Result};
+use crate::file_operations;
+use crate::str::CStr;
+
+/// Character device.
+///
+/// # Invariants
+///
+/// - [`self.0`] is valid and non-null.
+/// - [`(*self.0).ops`] is valid, non-null and has static lifetime.
+/// - [`(*self.0).owner`] is valid and, if non-null, has module lifetime.
+struct Cdev(*mut bindings::cdev);
+
+impl Cdev {
+    fn alloc(
+        fops: &'static bindings::file_operations,
+        module: &'static crate::ThisModule,
+    ) -> Result<Self> {
+        // SAFETY: FFI call.
+        let cdev = unsafe { bindings::cdev_alloc() };
+        if cdev.is_null() {
+            return Err(Error::ENOMEM);
+        }
+        // SAFETY: `cdev` is valid and non-null since `cdev_alloc()`
+        // returned a valid pointer which was null-checked.
+        unsafe {
+            (*cdev).ops = fops;
+            (*cdev).owner = module.0;
+        }
+        // INVARIANTS:
+        // - [`self.0`] is valid and non-null.
+        // - [`(*self.0).ops`] is valid, non-null and has static lifetime,
+        //   because it was coerced from a reference with static lifetime.
+        // - [`(*self.0).owner`] is valid and, if non-null, has module lifetime,
+        //   guaranteed by the [`ThisModule`] invariant.
+        Ok(Self(cdev))
+    }
+
+    fn add(&mut self, dev: bindings::dev_t, count: c_types::c_uint) -> Result {
+        // SAFETY: according to the type invariants:
+        // - [`self.0`] can be safely passed to [`bindings::cdev_add`].
+        // - [`(*self.0).ops`] will live at least as long as [`self.0`].
+        // - [`(*self.0).owner`] will live at least as long as the
+        //   module, which is an implicit requirement.
+        let rc = unsafe { bindings::cdev_add(self.0, dev, count) };
+        if rc != 0 {
+            return Err(Error::from_kernel_errno(rc));
+        }
+        Ok(())
+    }
+}
+
+impl Drop for Cdev {
+    fn drop(&mut self) {
+        // SAFETY: [`self.0`] is valid and non-null by the type invariants.
+        unsafe {
+            bindings::cdev_del(self.0);
+        }
+    }
+}
+
+struct RegistrationInner<const N: usize> {
+    dev: bindings::dev_t,
+    used: usize,
+    cdevs: [Option<Cdev>; N],
+    _pin: PhantomPinned,
+}
+
+/// Character device registration.
+///
+/// May contain up to a fixed number (`N`) of devices. Must be pinned.
+pub struct Registration<const N: usize> {
+    name: &'static CStr,
+    minors_start: u16,
+    this_module: &'static crate::ThisModule,
+    inner: Option<RegistrationInner<N>>,
+}
+
+impl<const N: usize> Registration<{ N }> {
+    /// Creates a [`Registration`] object for a character device.
+    ///
+    /// This does *not* register the device: see [`Self::register()`].
+    ///
+    /// This associated function is intended to be used when you need to avoid
+    /// a memory allocation, e.g. when the [`Registration`] is a member of
+    /// a bigger structure inside your [`crate::KernelModule`] instance. If you
+    /// are going to pin the registration right away, call
+    /// [`Self::new_pinned()`] instead.
+    pub fn new(
+        name: &'static CStr,
+        minors_start: u16,
+        this_module: &'static crate::ThisModule,
+    ) -> Self {
+        Registration {
+            name,
+            minors_start,
+            this_module,
+            inner: None,
+        }
+    }
+
+    /// Creates a pinned [`Registration`] object for a character device.
+    ///
+    /// This does *not* register the device: see [`Self::register()`].
+    pub fn new_pinned(
+        name: &'static CStr,
+        minors_start: u16,
+        this_module: &'static crate::ThisModule,
+    ) -> Result<Pin<Box<Self>>> {
+        Ok(Pin::from(Box::try_new(Self::new(
+            name,
+            minors_start,
+            this_module,
+        ))?))
+    }
+
+    /// Registers a character device.
+    ///
+    /// You may call this once per device type, up to `N` times.
+    pub fn register<T: file_operations::FileOpener<()>>(self: Pin<&mut Self>) -> Result {
+        // SAFETY: We must ensure that we never move out of `this`.
+        let this = unsafe { self.get_unchecked_mut() };
+        if this.inner.is_none() {
+            let mut dev: bindings::dev_t = 0;
+            // SAFETY: Calling unsafe function. `this.name` has `'static`
+            // lifetime.
+            let res = unsafe {
+                bindings::alloc_chrdev_region(
+                    &mut dev,
+                    this.minors_start.into(),
+                    N.try_into()?,
+                    this.name.as_char_ptr(),
+                )
+            };
+            if res != 0 {
+                return Err(Error::from_kernel_errno(res));
+            }
+            const NONE: Option<Cdev> = None;
+            this.inner = Some(RegistrationInner {
+                dev,
+                used: 0,
+                cdevs: [NONE; N],
+                _pin: PhantomPinned,
+            });
+        }
+
+        let mut inner = this.inner.as_mut().unwrap();
+        if inner.used == N {
+            return Err(Error::EINVAL);
+        }
+
+        // SAFETY: The adapter doesn't retrieve any state yet, so it's compatible with any
+        // registration.
+        let fops = unsafe { file_operations::FileOperationsVtable::<Self, T>::build() };
+        let mut cdev = Cdev::alloc(fops, this.this_module)?;
+        cdev.add(inner.dev + inner.used as bindings::dev_t, 1)?;
+        inner.cdevs[inner.used].replace(cdev);
+        inner.used += 1;
+        Ok(())
+    }
+}
+
+impl<const N: usize> file_operations::FileOpenAdapter for Registration<{ N }> {
+    type Arg = ();
+
+    unsafe fn convert(
+        _inode: *mut bindings::inode,
+        _file: *mut bindings::file,
+    ) -> *const Self::Arg {
+        // TODO: Update the SAFETY comment on the call to `FileOperationsVTable::build` above once
+        // this is updated to retrieve state.
+        &()
+    }
+}
+
+// SAFETY: `Registration` does not expose any of its state across threads
+// (it is fine for multiple threads to have a shared reference to it).
+unsafe impl<const N: usize> Sync for Registration<{ N }> {}
+
+impl<const N: usize> Drop for Registration<{ N }> {
+    fn drop(&mut self) {
+        if let Some(inner) = self.inner.as_mut() {
+            // Replicate kernel C behaviour: drop [`Cdev`]s before calling
+            // [`bindings::unregister_chrdev_region`].
+            for i in 0..inner.used {
+                inner.cdevs[i].take();
+            }
+            // SAFETY: [`self.inner`] is Some, so [`inner.dev`] was previously
+            // created using [`bindings::alloc_chrdev_region`].
+            unsafe {
+                bindings::unregister_chrdev_region(inner.dev, N.try_into().unwrap());
+            }
+        }
+    }
+}
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
new file mode 100644
index 00000000000..df7ba6a3661
--- /dev/null
+++ b/rust/kernel/error.rs
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Kernel errors.
+//!
+//! C header: [`include/uapi/asm-generic/errno-base.h`](../../../include/uapi/asm-generic/errno-base.h)
+
+use crate::str::CStr;
+use crate::{bindings, c_types};
+use alloc::{alloc::AllocError, collections::TryReserveError};
+use core::convert::From;
+use core::fmt;
+use core::num::TryFromIntError;
+use core::str::{self, Utf8Error};
+
+/// Generic integer kernel error.
+///
+/// The kernel defines a set of integer generic error codes based on C and
+/// POSIX ones. These codes may have a more specific meaning in some contexts.
+///
+/// # Invariants
+///
+/// The value is a valid `errno` (i.e. `>= -MAX_ERRNO && < 0`).
+#[derive(Clone, Copy, PartialEq, Eq)]
+pub struct Error(c_types::c_int);
+
+impl Error {
+    /// Invalid argument.
+    pub const EINVAL: Self = Error(-(bindings::EINVAL as i32));
+
+    /// Out of memory.
+    pub const ENOMEM: Self = Error(-(bindings::ENOMEM as i32));
+
+    /// Bad address.
+    pub const EFAULT: Self = Error(-(bindings::EFAULT as i32));
+
+    /// Illegal seek.
+    pub const ESPIPE: Self = Error(-(bindings::ESPIPE as i32));
+
+    /// Try again.
+    pub const EAGAIN: Self = Error(-(bindings::EAGAIN as i32));
+
+    /// Device or resource busy.
+    pub const EBUSY: Self = Error(-(bindings::EBUSY as i32));
+
+    /// Restart the system call.
+    pub const ERESTARTSYS: Self = Error(-(bindings::ERESTARTSYS as i32));
+
+    /// Operation not permitted.
+    pub const EPERM: Self = Error(-(bindings::EPERM as i32));
+
+    /// No such process.
+    pub const ESRCH: Self = Error(-(bindings::ESRCH as i32));
+
+    /// No such file or directory.
+    pub const ENOENT: Self = Error(-(bindings::ENOENT as i32));
+
+    /// Interrupted system call.
+    pub const EINTR: Self = Error(-(bindings::EINTR as i32));
+
+    /// Bad file number.
+    pub const EBADF: Self = Error(-(bindings::EBADF as i32));
+
+    /// Creates an [`Error`] from a kernel error code.
+    ///
+    /// It is a bug to pass an out-of-range `errno`. `EINVAL` would
+    /// be returned in such a case.
+    pub(crate) fn from_kernel_errno(errno: c_types::c_int) -> Error {
+        if errno < -(bindings::MAX_ERRNO as i32) || errno >= 0 {
+            // TODO: make it a `WARN_ONCE` once available.
+            crate::pr_warn!(
+                "attempted to create `Error` with out of range `errno`: {}",
+                errno
+            );
+            return Error::EINVAL;
+        }
+
+        // INVARIANT: the check above ensures the type invariant
+        // will hold.
+        Error(errno)
+    }
+
+    /// Creates an [`Error`] from a kernel error code.
+    ///
+    /// # Safety
+    ///
+    /// `errno` must be within error code range (i.e. `>= -MAX_ERRNO && < 0`).
+    pub(crate) unsafe fn from_kernel_errno_unchecked(errno: c_types::c_int) -> Error {
+        // INVARIANT: the contract ensures the type invariant
+        // will hold.
+        Error(errno)
+    }
+
+    /// Returns the kernel error code.
+    pub fn to_kernel_errno(self) -> c_types::c_int {
+        self.0
+    }
+}
+
+impl fmt::Debug for Error {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        extern "C" {
+            fn rust_helper_errname(err: c_types::c_int) -> *const c_types::c_char;
+        }
+        // SAFETY: FFI call.
+        let name = unsafe { rust_helper_errname(-self.0) };
+
+        if name.is_null() {
+            // Print out number if no name can be found.
+            return f.debug_tuple("Error").field(&-self.0).finish();
+        }
+
+        // SAFETY: `'static` string from C, and is not NULL.
+        let cstr = unsafe { CStr::from_char_ptr(name) };
+        // SAFETY: These strings are ASCII-only.
+        let str = unsafe { str::from_utf8_unchecked(cstr) };
+        f.debug_tuple(str).finish()
+    }
+}
+
+impl From<TryFromIntError> for Error {
+    fn from(_: TryFromIntError) -> Error {
+        Error::EINVAL
+    }
+}
+
+impl From<Utf8Error> for Error {
+    fn from(_: Utf8Error) -> Error {
+        Error::EINVAL
+    }
+}
+
+impl From<TryReserveError> for Error {
+    fn from(_: TryReserveError) -> Error {
+        Error::ENOMEM
+    }
+}
+
+/// A [`Result`] with an [`Error`] error type.
+///
+/// To be used as the return type for functions that may fail.
+///
+/// # Error codes in C and Rust
+///
+/// In C, it is common that functions indicate success or failure through
+/// their return value; modifying or returning extra data through non-`const`
+/// pointer parameters. In particular, in the kernel, functions that may fail
+/// typically return an `int` that represents a generic error code. We model
+/// those as [`Error`].
+///
+/// In Rust, it is idiomatic to model functions that may fail as returning
+/// a [`Result`]. Since in the kernel many functions return an error code,
+/// [`Result`] is a type alias for a [`core::result::Result`] that uses
+/// [`Error`] as its error type.
+///
+/// Note that even if a function does not return anything when it succeeds,
+/// it should still be modeled as returning a `Result` rather than
+/// just an [`Error`].
+pub type Result<T = ()> = core::result::Result<T, Error>;
+
+impl From<AllocError> for Error {
+    fn from(_: AllocError) -> Error {
+        Error::ENOMEM
+    }
+}
+
+// # Invariant: `-bindings::MAX_ERRNO` fits in an `i16`.
+crate::static_assert!(bindings::MAX_ERRNO <= -(i16::MIN as i32) as u32);
+
+#[doc(hidden)]
+pub fn from_kernel_result_helper<T>(r: Result<T>) -> T
+where
+    T: From<i16>,
+{
+    match r {
+        Ok(v) => v,
+        // NO-OVERFLOW: negative `errno`s are no smaller than `-bindings::MAX_ERRNO`,
+        // `-bindings::MAX_ERRNO` fits in an `i16` as per invariant above,
+        // therefore a negative `errno` always fits in an `i16` and will not overflow.
+        Err(e) => T::from(e.to_kernel_errno() as i16),
+    }
+}
+
+/// Transforms a [`crate::error::Result<T>`] to a kernel C integer result.
+///
+/// This is useful when calling Rust functions that return [`crate::error::Result<T>`]
+/// from inside `extern "C"` functions that need to return an integer
+/// error result.
+///
+/// `T` should be convertible to an `i16` via `From<i16>`.
+///
+/// # Examples
+///
+/// ```ignore
+/// # use kernel::from_kernel_result;
+/// # use kernel::c_types;
+/// # use kernel::bindings;
+/// unsafe extern "C" fn probe_callback(
+///     pdev: *mut bindings::platform_device,
+/// ) -> c_types::c_int {
+///     from_kernel_result! {
+///         let ptr = devm_alloc(pdev)?;
+///         rust_helper_platform_set_drvdata(pdev, ptr);
+///         Ok(0)
+///     }
+/// }
+/// ```
+#[macro_export]
+macro_rules! from_kernel_result {
+    ($($tt:tt)*) => {{
+        $crate::error::from_kernel_result_helper((|| {
+            $($tt)*
+        })())
+    }};
+}
+
+/// Transform a kernel "error pointer" to a normal pointer.
+///
+/// Some kernel C API functions return an "error pointer" which optionally
+/// embeds an `errno`. Callers are supposed to check the returned pointer
+/// for errors. This function performs the check and converts the "error pointer"
+/// to a normal pointer in an idiomatic fashion.
+///
+/// # Examples
+///
+/// ```ignore
+/// # use kernel::prelude::*;
+/// # use kernel::from_kernel_err_ptr;
+/// # use kernel::c_types;
+/// # use kernel::bindings;
+/// fn devm_platform_ioremap_resource(
+///     pdev: &mut PlatformDevice,
+///     index: u32,
+/// ) -> Result<*mut c_types::c_void> {
+///     // SAFETY: FFI call.
+///     unsafe {
+///         from_kernel_err_ptr(bindings::devm_platform_ioremap_resource(
+///             pdev.to_ptr(),
+///             index,
+///         ))
+///     }
+/// }
+/// ```
+// TODO: remove `dead_code` marker once an in-kernel client is available.
+#[allow(dead_code)]
+pub(crate) fn from_kernel_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
+    extern "C" {
+        #[allow(improper_ctypes)]
+        fn rust_helper_is_err(ptr: *const c_types::c_void) -> bool;
+
+        #[allow(improper_ctypes)]
+        fn rust_helper_ptr_err(ptr: *const c_types::c_void) -> c_types::c_long;
+    }
+
+    // CAST: casting a pointer to `*const c_types::c_void` is always valid.
+    let const_ptr: *const c_types::c_void = ptr.cast();
+    // SAFETY: the FFI function does not deref the pointer.
+    if unsafe { rust_helper_is_err(const_ptr) } {
+        // SAFETY: the FFI function does not deref the pointer.
+        let err = unsafe { rust_helper_ptr_err(const_ptr) };
+        // CAST: if `rust_helper_is_err()` returns `true`,
+        // then `rust_helper_ptr_err()` is guaranteed to return a
+        // negative value greater-or-equal to `-bindings::MAX_ERRNO`,
+        // which always fits in an `i16`, as per the invariant above.
+        // And an `i16` always fits in an `i32`. So casting `err` to
+        // an `i32` can never overflow, and is always valid.
+        //
+        // SAFETY: `rust_helper_is_err()` ensures `err` is a
+        // negative value greater-or-equal to `-bindings::MAX_ERRNO`
+        return Err(unsafe { Error::from_kernel_errno_unchecked(err as i32) });
+    }
+    Ok(ptr)
+}
diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
new file mode 100644
index 00000000000..091b3a4306c
--- /dev/null
+++ b/rust/kernel/file.rs
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Files and file descriptors.
+//!
+//! C headers: [`include/linux/fs.h`](../../../../include/linux/fs.h) and
+//! [`include/linux/file.h`](../../../../include/linux/file.h)
+
+use crate::{bindings, error::Error, Result};
+use core::{mem::ManuallyDrop, ops::Deref};
+
+/// Wraps the kernel's `struct file`.
+///
+/// # Invariants
+///
+/// The pointer `File::ptr` is non-null and valid. Its reference count is also non-zero.
+pub struct File {
+    pub(crate) ptr: *mut bindings::file,
+}
+
+impl File {
+    /// Constructs a new [`struct file`] wrapper from a file descriptor.
+    ///
+    /// The file descriptor belongs to the current process.
+    pub fn from_fd(fd: u32) -> Result<Self> {
+        // SAFETY: FFI call, there are no requirements on `fd`.
+        let ptr = unsafe { bindings::fget(fd) };
+        if ptr.is_null() {
+            return Err(Error::EBADF);
+        }
+
+        // INVARIANTS: We checked that `ptr` is non-null, so it is valid. `fget` increments the ref
+        // count before returning.
+        Ok(Self { ptr })
+    }
+
+    /// Returns the current seek/cursor/pointer position (`struct file::f_pos`).
+    pub fn pos(&self) -> u64 {
+        // SAFETY: `File::ptr` is guaranteed to be valid by the type invariants.
+        unsafe { (*self.ptr).f_pos as u64 }
+    }
+
+    /// Returns whether the file is in blocking mode.
+    pub fn is_blocking(&self) -> bool {
+        // SAFETY: `File::ptr` is guaranteed to be valid by the type invariants.
+        unsafe { (*self.ptr).f_flags & bindings::O_NONBLOCK == 0 }
+    }
+}
+
+impl Drop for File {
+    fn drop(&mut self) {
+        // SAFETY: The type invariants guarantee that `File::ptr` has a non-zero reference count.
+        unsafe { bindings::fput(self.ptr) };
+    }
+}
+
+/// A wrapper for [`File`] that doesn't automatically decrement the refcount when dropped.
+///
+/// We need the wrapper because [`ManuallyDrop`] alone would allow callers to call
+/// [`ManuallyDrop::into_inner`]. This would allow an unsafe sequence to be triggered without
+/// `unsafe` blocks because it would trigger an unbalanced call to `fput`.
+///
+/// # Invariants
+///
+/// The wrapped [`File`] remains valid for the lifetime of the object.
+pub(crate) struct FileRef(ManuallyDrop<File>);
+
+impl FileRef {
+    /// Constructs a new [`struct file`] wrapper that doesn't change its reference count.
+    ///
+    /// # Safety
+    ///
+    /// The pointer `ptr` must be non-null and valid for the lifetime of the object.
+    pub(crate) unsafe fn from_ptr(ptr: *mut bindings::file) -> Self {
+        Self(ManuallyDrop::new(File { ptr }))
+    }
+}
+
+impl Deref for FileRef {
+    type Target = File;
+
+    fn deref(&self) -> &Self::Target {
+        self.0.deref()
+    }
+}
+
+/// A file descriptor reservation.
+///
+/// This allows the creation of a file descriptor in two steps: first, we reserve a slot for it,
+/// then we commit or drop the reservation. The first step may fail (e.g., the current process ran
+/// out of available slots), but commit and drop never fail (and are mutually exclusive).
+pub struct FileDescriptorReservation {
+    fd: u32,
+}
+
+impl FileDescriptorReservation {
+    /// Creates a new file descriptor reservation.
+    pub fn new(flags: u32) -> Result<Self> {
+        let fd = unsafe { bindings::get_unused_fd_flags(flags) };
+        if fd < 0 {
+            return Err(Error::from_kernel_errno(fd));
+        }
+        Ok(Self { fd: fd as _ })
+    }
+
+    /// Returns the file descriptor number that was reserved.
+    pub fn reserved_fd(&self) -> u32 {
+        self.fd
+    }
+
+    /// Commits the reservation.
+    ///
+    /// The previously reserved file descriptor is bound to `file`.
+    pub fn commit(self, file: File) {
+        // SAFETY: `self.fd` was previously returned by `get_unused_fd_flags`, and `file.ptr` is
+        // guaranteed to have an owned ref count by its type invariants.
+        unsafe { bindings::fd_install(self.fd, file.ptr) };
+
+        // `fd_install` consumes both the file descriptor and the file reference, so we cannot run
+        // the destructors.
+        core::mem::forget(self);
+        core::mem::forget(file);
+    }
+}
+
+impl Drop for FileDescriptorReservation {
+    fn drop(&mut self) {
+        // SAFETY: `self.fd` was returned by a previous call to `get_unused_fd_flags`.
+        unsafe { bindings::put_unused_fd(self.fd) };
+    }
+}
diff --git a/rust/kernel/file_operations.rs b/rust/kernel/file_operations.rs
new file mode 100644
index 00000000000..b866b666856
--- /dev/null
+++ b/rust/kernel/file_operations.rs
@@ -0,0 +1,698 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! File operations.
+//!
+//! C header: [`include/linux/fs.h`](../../../../include/linux/fs.h)
+
+use core::convert::{TryFrom, TryInto};
+use core::{marker, mem, ops::Deref, ptr};
+
+use alloc::boxed::Box;
+
+use crate::{
+    bindings, c_types,
+    error::{Error, Result},
+    file::{File, FileRef},
+    from_kernel_result,
+    io_buffer::{IoBufferReader, IoBufferWriter},
+    iov_iter::IovIter,
+    sync::CondVar,
+    types::PointerWrapper,
+    user_ptr::{UserSlicePtr, UserSlicePtrReader, UserSlicePtrWriter},
+};
+
+/// Wraps the kernel's `struct poll_table_struct`.
+///
+/// # Invariants
+///
+/// The pointer `PollTable::ptr` is null or valid.
+pub struct PollTable {
+    ptr: *mut bindings::poll_table_struct,
+}
+
+impl PollTable {
+    /// Constructors a new `struct poll_table_struct` wrapper.
+    ///
+    /// # Safety
+    ///
+    /// The pointer `ptr` must be either null or a valid pointer for the lifetime of the object.
+    unsafe fn from_ptr(ptr: *mut bindings::poll_table_struct) -> Self {
+        Self { ptr }
+    }
+
+    /// Associates the given file and condition variable to this poll table. It means notifying the
+    /// condition variable will notify the poll table as well; additionally, the association
+    /// between the condition variable and the file will automatically be undone by the kernel when
+    /// the file is destructed. To unilaterally remove the association before then, one can call
+    /// [`CondVar::free_waiters`].
+    ///
+    /// # Safety
+    ///
+    /// If the condition variable is destroyed before the file, then [`CondVar::free_waiters`] must
+    /// be called to ensure that all waiters are flushed out.
+    pub unsafe fn register_wait<'a>(&self, file: &'a File, cv: &'a CondVar) {
+        if self.ptr.is_null() {
+            return;
+        }
+
+        // SAFETY: `PollTable::ptr` is guaranteed to be valid by the type invariants and the null
+        // check above.
+        let table = unsafe { &*self.ptr };
+        if let Some(proc) = table._qproc {
+            // SAFETY: All pointers are known to be valid.
+            unsafe { proc(file.ptr as _, cv.wait_list.get(), self.ptr) }
+        }
+    }
+}
+
+/// Equivalent to [`std::io::SeekFrom`].
+///
+/// [`std::io::SeekFrom`]: https://doc.rust-lang.org/std/io/enum.SeekFrom.html
+pub enum SeekFrom {
+    /// Equivalent to C's `SEEK_SET`.
+    Start(u64),
+
+    /// Equivalent to C's `SEEK_END`.
+    End(i64),
+
+    /// Equivalent to C's `SEEK_CUR`.
+    Current(i64),
+}
+
+unsafe extern "C" fn open_callback<A: FileOpenAdapter, T: FileOpener<A::Arg>>(
+    inode: *mut bindings::inode,
+    file: *mut bindings::file,
+) -> c_types::c_int {
+    from_kernel_result! {
+        let arg = unsafe { A::convert(inode, file) };
+        let ptr = T::open(unsafe { &*arg })?.into_pointer();
+        unsafe { (*file).private_data = ptr as *mut c_types::c_void };
+        Ok(0)
+    }
+}
+
+unsafe extern "C" fn read_callback<T: FileOperations>(
+    file: *mut bindings::file,
+    buf: *mut c_types::c_char,
+    len: c_types::c_size_t,
+    offset: *mut bindings::loff_t,
+) -> c_types::c_ssize_t {
+    from_kernel_result! {
+        let mut data = unsafe { UserSlicePtr::new(buf as *mut c_types::c_void, len).writer() };
+        // SAFETY: `private_data` was initialised by `open_callback` with a value returned by
+        // `T::Wrapper::into_pointer`. `T::Wrapper::from_pointer` is only called by the `release`
+        // callback, which the C API guarantees that will be called only when all references to
+        // `file` have been released, so we know it can't be called while this function is running.
+        let f = unsafe { T::Wrapper::borrow((*file).private_data) };
+        // No `FMODE_UNSIGNED_OFFSET` support, so `offset` must be in [0, 2^63).
+        // See discussion in https://github.com/fishinabarrel/linux-kernel-module-rust/pull/113
+        let read = T::read(&f, unsafe { &FileRef::from_ptr(file) }, &mut data, unsafe { *offset }.try_into()?)?;
+        unsafe { (*offset) += bindings::loff_t::try_from(read).unwrap() };
+        Ok(read as _)
+    }
+}
+
+unsafe extern "C" fn read_iter_callback<T: FileOperations>(
+    iocb: *mut bindings::kiocb,
+    raw_iter: *mut bindings::iov_iter,
+) -> isize {
+    from_kernel_result! {
+        let mut iter = unsafe { IovIter::from_ptr(raw_iter) };
+        let file = unsafe { (*iocb).ki_filp };
+        let offset = unsafe { (*iocb).ki_pos };
+        // SAFETY: `private_data` was initialised by `open_callback` with a value returned by
+        // `T::Wrapper::into_pointer`. `T::Wrapper::from_pointer` is only called by the `release`
+        // callback, which the C API guarantees that will be called only when all references to
+        // `file` have been released, so we know it can't be called while this function is running.
+        let f = unsafe { T::Wrapper::borrow((*file).private_data) };
+        let read = T::read(&f, unsafe { &FileRef::from_ptr(file) }, &mut iter, offset.try_into()?)?;
+        unsafe { (*iocb).ki_pos += bindings::loff_t::try_from(read).unwrap() };
+        Ok(read as _)
+    }
+}
+
+unsafe extern "C" fn write_callback<T: FileOperations>(
+    file: *mut bindings::file,
+    buf: *const c_types::c_char,
+    len: c_types::c_size_t,
+    offset: *mut bindings::loff_t,
+) -> c_types::c_ssize_t {
+    from_kernel_result! {
+        let mut data = unsafe { UserSlicePtr::new(buf as *mut c_types::c_void, len).reader() };
+        // SAFETY: `private_data` was initialised by `open_callback` with a value returned by
+        // `T::Wrapper::into_pointer`. `T::Wrapper::from_pointer` is only called by the `release`
+        // callback, which the C API guarantees that will be called only when all references to
+        // `file` have been released, so we know it can't be called while this function is running.
+        let f = unsafe { T::Wrapper::borrow((*file).private_data) };
+        // No `FMODE_UNSIGNED_OFFSET` support, so `offset` must be in [0, 2^63).
+        // See discussion in https://github.com/fishinabarrel/linux-kernel-module-rust/pull/113
+        let written = T::write(&f, unsafe { &FileRef::from_ptr(file) }, &mut data, unsafe { *offset }.try_into()?)?;
+        unsafe { (*offset) += bindings::loff_t::try_from(written).unwrap() };
+        Ok(written as _)
+    }
+}
+
+unsafe extern "C" fn write_iter_callback<T: FileOperations>(
+    iocb: *mut bindings::kiocb,
+    raw_iter: *mut bindings::iov_iter,
+) -> isize {
+    from_kernel_result! {
+        let mut iter = unsafe { IovIter::from_ptr(raw_iter) };
+        let file = unsafe { (*iocb).ki_filp };
+        let offset = unsafe { (*iocb).ki_pos };
+        // SAFETY: `private_data` was initialised by `open_callback` with a value returned by
+        // `T::Wrapper::into_pointer`. `T::Wrapper::from_pointer` is only called by the `release`
+        // callback, which the C API guarantees that will be called only when all references to
+        // `file` have been released, so we know it can't be called while this function is running.
+        let f = unsafe { T::Wrapper::borrow((*file).private_data) };
+        let written = T::write(&f, unsafe { &FileRef::from_ptr(file) }, &mut iter, offset.try_into()?)?;
+        unsafe { (*iocb).ki_pos += bindings::loff_t::try_from(written).unwrap() };
+        Ok(written as _)
+    }
+}
+
+unsafe extern "C" fn release_callback<T: FileOperations>(
+    _inode: *mut bindings::inode,
+    file: *mut bindings::file,
+) -> c_types::c_int {
+    let ptr = mem::replace(unsafe { &mut (*file).private_data }, ptr::null_mut());
+    T::release(unsafe { T::Wrapper::from_pointer(ptr as _) }, unsafe {
+        &FileRef::from_ptr(file)
+    });
+    0
+}
+
+unsafe extern "C" fn llseek_callback<T: FileOperations>(
+    file: *mut bindings::file,
+    offset: bindings::loff_t,
+    whence: c_types::c_int,
+) -> bindings::loff_t {
+    from_kernel_result! {
+        let off = match whence as u32 {
+            bindings::SEEK_SET => SeekFrom::Start(offset.try_into()?),
+            bindings::SEEK_CUR => SeekFrom::Current(offset),
+            bindings::SEEK_END => SeekFrom::End(offset),
+            _ => return Err(Error::EINVAL),
+        };
+        // SAFETY: `private_data` was initialised by `open_callback` with a value returned by
+        // `T::Wrapper::into_pointer`. `T::Wrapper::from_pointer` is only called by the `release`
+        // callback, which the C API guarantees that will be called only when all references to
+        // `file` have been released, so we know it can't be called while this function is running.
+        let f = unsafe { T::Wrapper::borrow((*file).private_data) };
+        let off = T::seek(&f, unsafe { &FileRef::from_ptr(file) }, off)?;
+        Ok(off as bindings::loff_t)
+    }
+}
+
+unsafe extern "C" fn unlocked_ioctl_callback<T: FileOperations>(
+    file: *mut bindings::file,
+    cmd: c_types::c_uint,
+    arg: c_types::c_ulong,
+) -> c_types::c_long {
+    from_kernel_result! {
+        // SAFETY: `private_data` was initialised by `open_callback` with a value returned by
+        // `T::Wrapper::into_pointer`. `T::Wrapper::from_pointer` is only called by the `release`
+        // callback, which the C API guarantees that will be called only when all references to
+        // `file` have been released, so we know it can't be called while this function is running.
+        let f = unsafe { T::Wrapper::borrow((*file).private_data) };
+        let mut cmd = IoctlCommand::new(cmd as _, arg as _);
+        let ret = T::ioctl(&f, unsafe { &FileRef::from_ptr(file) }, &mut cmd)?;
+        Ok(ret as _)
+    }
+}
+
+unsafe extern "C" fn compat_ioctl_callback<T: FileOperations>(
+    file: *mut bindings::file,
+    cmd: c_types::c_uint,
+    arg: c_types::c_ulong,
+) -> c_types::c_long {
+    from_kernel_result! {
+        // SAFETY: `private_data` was initialised by `open_callback` with a value returned by
+        // `T::Wrapper::into_pointer`. `T::Wrapper::from_pointer` is only called by the `release`
+        // callback, which the C API guarantees that will be called only when all references to
+        // `file` have been released, so we know it can't be called while this function is running.
+        let f = unsafe { T::Wrapper::borrow((*file).private_data) };
+        let mut cmd = IoctlCommand::new(cmd as _, arg as _);
+        let ret = T::compat_ioctl(&f, unsafe { &FileRef::from_ptr(file) }, &mut cmd)?;
+        Ok(ret as _)
+    }
+}
+
+unsafe extern "C" fn mmap_callback<T: FileOperations>(
+    file: *mut bindings::file,
+    vma: *mut bindings::vm_area_struct,
+) -> c_types::c_int {
+    from_kernel_result! {
+        // SAFETY: `private_data` was initialised by `open_callback` with a value returned by
+        // `T::Wrapper::into_pointer`. `T::Wrapper::from_pointer` is only called by the `release`
+        // callback, which the C API guarantees that will be called only when all references to
+        // `file` have been released, so we know it can't be called while this function is running.
+        let f = unsafe { T::Wrapper::borrow((*file).private_data) };
+        T::mmap(&f, unsafe { &FileRef::from_ptr(file) }, unsafe { &mut *vma })?;
+        Ok(0)
+    }
+}
+
+unsafe extern "C" fn fsync_callback<T: FileOperations>(
+    file: *mut bindings::file,
+    start: bindings::loff_t,
+    end: bindings::loff_t,
+    datasync: c_types::c_int,
+) -> c_types::c_int {
+    from_kernel_result! {
+        let start = start.try_into()?;
+        let end = end.try_into()?;
+        let datasync = datasync != 0;
+        // SAFETY: `private_data` was initialised by `open_callback` with a value returned by
+        // `T::Wrapper::into_pointer`. `T::Wrapper::from_pointer` is only called by the `release`
+        // callback, which the C API guarantees that will be called only when all references to
+        // `file` have been released, so we know it can't be called while this function is running.
+        let f = unsafe { T::Wrapper::borrow((*file).private_data) };
+        let res = T::fsync(&f, unsafe { &FileRef::from_ptr(file) }, start, end, datasync)?;
+        Ok(res.try_into().unwrap())
+    }
+}
+
+unsafe extern "C" fn poll_callback<T: FileOperations>(
+    file: *mut bindings::file,
+    wait: *mut bindings::poll_table_struct,
+) -> bindings::__poll_t {
+    // SAFETY: `private_data` was initialised by `open_callback` with a value returned by
+    // `T::Wrapper::into_pointer`. `T::Wrapper::from_pointer` is only called by the `release`
+    // callback, which the C API guarantees that will be called only when all references to `file`
+    // have been released, so we know it can't be called while this function is running.
+    let f = unsafe { T::Wrapper::borrow((*file).private_data) };
+    match T::poll(&f, unsafe { &FileRef::from_ptr(file) }, unsafe {
+        &PollTable::from_ptr(wait)
+    }) {
+        Ok(v) => v,
+        Err(_) => bindings::POLLERR,
+    }
+}
+
+pub(crate) struct FileOperationsVtable<A, T>(marker::PhantomData<A>, marker::PhantomData<T>);
+
+impl<A: FileOpenAdapter, T: FileOpener<A::Arg>> FileOperationsVtable<A, T> {
+    const VTABLE: bindings::file_operations = bindings::file_operations {
+        open: Some(open_callback::<A, T>),
+        release: Some(release_callback::<T>),
+        read: if T::TO_USE.read {
+            Some(read_callback::<T>)
+        } else {
+            None
+        },
+        write: if T::TO_USE.write {
+            Some(write_callback::<T>)
+        } else {
+            None
+        },
+        llseek: if T::TO_USE.seek {
+            Some(llseek_callback::<T>)
+        } else {
+            None
+        },
+
+        check_flags: None,
+        compat_ioctl: if T::TO_USE.compat_ioctl {
+            Some(compat_ioctl_callback::<T>)
+        } else {
+            None
+        },
+        copy_file_range: None,
+        fallocate: None,
+        fadvise: None,
+        fasync: None,
+        flock: None,
+        flush: None,
+        fsync: if T::TO_USE.fsync {
+            Some(fsync_callback::<T>)
+        } else {
+            None
+        },
+        get_unmapped_area: None,
+        iterate: None,
+        iterate_shared: None,
+        iopoll: None,
+        lock: None,
+        mmap: if T::TO_USE.mmap {
+            Some(mmap_callback::<T>)
+        } else {
+            None
+        },
+        mmap_supported_flags: 0,
+        owner: ptr::null_mut(),
+        poll: if T::TO_USE.poll {
+            Some(poll_callback::<T>)
+        } else {
+            None
+        },
+        read_iter: if T::TO_USE.read_iter {
+            Some(read_iter_callback::<T>)
+        } else {
+            None
+        },
+        remap_file_range: None,
+        sendpage: None,
+        setlease: None,
+        show_fdinfo: None,
+        splice_read: None,
+        splice_write: None,
+        unlocked_ioctl: if T::TO_USE.ioctl {
+            Some(unlocked_ioctl_callback::<T>)
+        } else {
+            None
+        },
+        write_iter: if T::TO_USE.write_iter {
+            Some(write_iter_callback::<T>)
+        } else {
+            None
+        },
+    };
+
+    /// Builds an instance of [`struct file_operations`].
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that the adapter is compatible with the way the device is registered.
+    pub(crate) const unsafe fn build() -> &'static bindings::file_operations {
+        &Self::VTABLE
+    }
+}
+
+/// Represents which fields of [`struct file_operations`] should be populated with pointers.
+pub struct ToUse {
+    /// The `read` field of [`struct file_operations`].
+    pub read: bool,
+
+    /// The `read_iter` field of [`struct file_operations`].
+    pub read_iter: bool,
+
+    /// The `write` field of [`struct file_operations`].
+    pub write: bool,
+
+    /// The `write_iter` field of [`struct file_operations`].
+    pub write_iter: bool,
+
+    /// The `llseek` field of [`struct file_operations`].
+    pub seek: bool,
+
+    /// The `unlocked_ioctl` field of [`struct file_operations`].
+    pub ioctl: bool,
+
+    /// The `compat_ioctl` field of [`struct file_operations`].
+    pub compat_ioctl: bool,
+
+    /// The `fsync` field of [`struct file_operations`].
+    pub fsync: bool,
+
+    /// The `mmap` field of [`struct file_operations`].
+    pub mmap: bool,
+
+    /// The `poll` field of [`struct file_operations`].
+    pub poll: bool,
+}
+
+/// A constant version where all values are to set to `false`, that is, all supported fields will
+/// be set to null pointers.
+pub const USE_NONE: ToUse = ToUse {
+    read: false,
+    read_iter: false,
+    write: false,
+    write_iter: false,
+    seek: false,
+    ioctl: false,
+    compat_ioctl: false,
+    fsync: false,
+    mmap: false,
+    poll: false,
+};
+
+/// Defines the [`FileOperations::TO_USE`] field based on a list of fields to be populated.
+#[macro_export]
+macro_rules! declare_file_operations {
+    () => {
+        const TO_USE: $crate::file_operations::ToUse = $crate::file_operations::USE_NONE;
+    };
+    ($($i:ident),+) => {
+        const TO_USE: kernel::file_operations::ToUse =
+            $crate::file_operations::ToUse {
+                $($i: true),+ ,
+                ..$crate::file_operations::USE_NONE
+            };
+    };
+}
+
+/// Allows the handling of ioctls defined with the `_IO`, `_IOR`, `_IOW`, and `_IOWR` macros.
+///
+/// For each macro, there is a handler function that takes the appropriate types as arguments.
+pub trait IoctlHandler: Sync {
+    /// The type of the first argument to each associated function.
+    type Target;
+
+    /// Handles ioctls defined with the `_IO` macro, that is, with no buffer as argument.
+    fn pure(_this: &Self::Target, _file: &File, _cmd: u32, _arg: usize) -> Result<i32> {
+        Err(Error::EINVAL)
+    }
+
+    /// Handles ioctls defined with the `_IOR` macro, that is, with an output buffer provided as
+    /// argument.
+    fn read(
+        _this: &Self::Target,
+        _file: &File,
+        _cmd: u32,
+        _writer: &mut UserSlicePtrWriter,
+    ) -> Result<i32> {
+        Err(Error::EINVAL)
+    }
+
+    /// Handles ioctls defined with the `_IOW` macro, that is, with an input buffer provided as
+    /// argument.
+    fn write(
+        _this: &Self::Target,
+        _file: &File,
+        _cmd: u32,
+        _reader: &mut UserSlicePtrReader,
+    ) -> Result<i32> {
+        Err(Error::EINVAL)
+    }
+
+    /// Handles ioctls defined with the `_IOWR` macro, that is, with a buffer for both input and
+    /// output provided as argument.
+    fn read_write(
+        _this: &Self::Target,
+        _file: &File,
+        _cmd: u32,
+        _data: UserSlicePtr,
+    ) -> Result<i32> {
+        Err(Error::EINVAL)
+    }
+}
+
+/// Represents an ioctl command.
+///
+/// It can use the components of an ioctl command to dispatch ioctls using
+/// [`IoctlCommand::dispatch`].
+pub struct IoctlCommand {
+    cmd: u32,
+    arg: usize,
+    user_slice: Option<UserSlicePtr>,
+}
+
+impl IoctlCommand {
+    /// Constructs a new [`IoctlCommand`].
+    fn new(cmd: u32, arg: usize) -> Self {
+        let size = (cmd >> bindings::_IOC_SIZESHIFT) & bindings::_IOC_SIZEMASK;
+
+        // SAFETY: We only create one instance of the user slice per ioctl call, so TOCTOU issues
+        // are not possible.
+        let user_slice = Some(unsafe { UserSlicePtr::new(arg as _, size as _) });
+        Self {
+            cmd,
+            arg,
+            user_slice,
+        }
+    }
+
+    /// Dispatches the given ioctl to the appropriate handler based on the value of the command. It
+    /// also creates a [`UserSlicePtr`], [`UserSlicePtrReader`], or [`UserSlicePtrWriter`]
+    /// depending on the direction of the buffer of the command.
+    ///
+    /// It is meant to be used in implementations of [`FileOperations::ioctl`] and
+    /// [`FileOperations::compat_ioctl`].
+    pub fn dispatch<T: IoctlHandler>(&mut self, handler: &T::Target, file: &File) -> Result<i32> {
+        let dir = (self.cmd >> bindings::_IOC_DIRSHIFT) & bindings::_IOC_DIRMASK;
+        if dir == bindings::_IOC_NONE {
+            return T::pure(handler, file, self.cmd, self.arg);
+        }
+
+        let data = self.user_slice.take().ok_or(Error::EINVAL)?;
+        const READ_WRITE: u32 = bindings::_IOC_READ | bindings::_IOC_WRITE;
+        match dir {
+            bindings::_IOC_WRITE => T::write(handler, file, self.cmd, &mut data.reader()),
+            bindings::_IOC_READ => T::read(handler, file, self.cmd, &mut data.writer()),
+            READ_WRITE => T::read_write(handler, file, self.cmd, data),
+            _ => Err(Error::EINVAL),
+        }
+    }
+
+    /// Returns the raw 32-bit value of the command and the ptr-sized argument.
+    pub fn raw(&self) -> (u32, usize) {
+        (self.cmd, self.arg)
+    }
+}
+
+/// Trait for extracting file open arguments from kernel data structures.
+///
+/// This is meant to be implemented by registration managers.
+pub trait FileOpenAdapter {
+    /// The type of argument this adapter extracts.
+    type Arg;
+
+    /// Converts untyped data stored in [`struct inode`] and [`struct file`] (when [`struct
+    /// file_operations::open`] is called) into the given type. For example, for `miscdev`
+    /// devices, a pointer to the registered [`struct miscdev`] is stored in [`struct
+    /// file::private_data`].
+    ///
+    /// # Safety
+    ///
+    /// This function must be called only when [`struct file_operations::open`] is being called for
+    /// a file that was registered by the implementer.
+    unsafe fn convert(_inode: *mut bindings::inode, _file: *mut bindings::file)
+        -> *const Self::Arg;
+}
+
+/// Trait for implementers of kernel files.
+///
+/// In addition to the methods in [`FileOperations`], implementers must also provide
+/// [`FileOpener::open`] with a customised argument. This allows a single implementation of
+/// [`FileOperations`] to be used for different types of registrations, for example, `miscdev` and
+/// `chrdev`.
+pub trait FileOpener<T: ?Sized>: FileOperations {
+    /// Creates a new instance of this file.
+    ///
+    /// Corresponds to the `open` function pointer in `struct file_operations`.
+    fn open(context: &T) -> Result<Self::Wrapper>;
+}
+
+impl<T: FileOperations<Wrapper = Box<T>> + Default> FileOpener<()> for T {
+    fn open(_: &()) -> Result<Self::Wrapper> {
+        Ok(Box::try_new(T::default())?)
+    }
+}
+
+/// Corresponds to the kernel's `struct file_operations`.
+///
+/// You implement this trait whenever you would create a `struct file_operations`.
+///
+/// File descriptors may be used from multiple threads/processes concurrently, so your type must be
+/// [`Sync`]. It must also be [`Send`] because [`FileOperations::release`] will be called from the
+/// thread that decrements that associated file's refcount to zero.
+pub trait FileOperations: Send + Sync + Sized {
+    /// The methods to use to populate [`struct file_operations`].
+    const TO_USE: ToUse;
+
+    /// The pointer type that will be used to hold ourselves.
+    type Wrapper: PointerWrapper = Box<Self>;
+
+    /// Cleans up after the last reference to the file goes away.
+    ///
+    /// Note that the object is moved, so it will be freed automatically unless the implementation
+    /// moves it elsewhere.
+    ///
+    /// Corresponds to the `release` function pointer in `struct file_operations`.
+    fn release(_obj: Self::Wrapper, _file: &File) {}
+
+    /// Reads data from this file to the caller's buffer.
+    ///
+    /// Corresponds to the `read` and `read_iter` function pointers in `struct file_operations`.
+    fn read<T: IoBufferWriter>(
+        _this: &<<Self::Wrapper as PointerWrapper>::Borrowed as Deref>::Target,
+        _file: &File,
+        _data: &mut T,
+        _offset: u64,
+    ) -> Result<usize> {
+        Err(Error::EINVAL)
+    }
+
+    /// Writes data from the caller's buffer to this file.
+    ///
+    /// Corresponds to the `write` and `write_iter` function pointers in `struct file_operations`.
+    fn write<T: IoBufferReader>(
+        _this: &<<Self::Wrapper as PointerWrapper>::Borrowed as Deref>::Target,
+        _file: &File,
+        _data: &mut T,
+        _offset: u64,
+    ) -> Result<usize> {
+        Err(Error::EINVAL)
+    }
+
+    /// Changes the position of the file.
+    ///
+    /// Corresponds to the `llseek` function pointer in `struct file_operations`.
+    fn seek(
+        _this: &<<Self::Wrapper as PointerWrapper>::Borrowed as Deref>::Target,
+        _file: &File,
+        _offset: SeekFrom,
+    ) -> Result<u64> {
+        Err(Error::EINVAL)
+    }
+
+    /// Performs IO control operations that are specific to the file.
+    ///
+    /// Corresponds to the `unlocked_ioctl` function pointer in `struct file_operations`.
+    fn ioctl(
+        _this: &<<Self::Wrapper as PointerWrapper>::Borrowed as Deref>::Target,
+        _file: &File,
+        _cmd: &mut IoctlCommand,
+    ) -> Result<i32> {
+        Err(Error::EINVAL)
+    }
+
+    /// Performs 32-bit IO control operations on that are specific to the file on 64-bit kernels.
+    ///
+    /// Corresponds to the `compat_ioctl` function pointer in `struct file_operations`.
+    fn compat_ioctl(
+        _this: &<<Self::Wrapper as PointerWrapper>::Borrowed as Deref>::Target,
+        _file: &File,
+        _cmd: &mut IoctlCommand,
+    ) -> Result<i32> {
+        Err(Error::EINVAL)
+    }
+
+    /// Syncs pending changes to this file.
+    ///
+    /// Corresponds to the `fsync` function pointer in `struct file_operations`.
+    fn fsync(
+        _this: &<<Self::Wrapper as PointerWrapper>::Borrowed as Deref>::Target,
+        _file: &File,
+        _start: u64,
+        _end: u64,
+        _datasync: bool,
+    ) -> Result<u32> {
+        Err(Error::EINVAL)
+    }
+
+    /// Maps areas of the caller's virtual memory with device/file memory.
+    ///
+    /// Corresponds to the `mmap` function pointer in `struct file_operations`.
+    /// TODO: wrap `vm_area_struct` so that we don't have to expose it.
+    fn mmap(
+        _this: &<<Self::Wrapper as PointerWrapper>::Borrowed as Deref>::Target,
+        _file: &File,
+        _vma: &mut bindings::vm_area_struct,
+    ) -> Result {
+        Err(Error::EINVAL)
+    }
+
+    /// Checks the state of the file and optionally registers for notification when the state
+    /// changes.
+    ///
+    /// Corresponds to the `poll` function pointer in `struct file_operations`.
+    fn poll(
+        _this: &<<Self::Wrapper as PointerWrapper>::Borrowed as Deref>::Target,
+        _file: &File,
+        _table: &PollTable,
+    ) -> Result<u32> {
+        Ok(bindings::POLLIN | bindings::POLLOUT | bindings::POLLRDNORM | bindings::POLLWRNORM)
+    }
+}
diff --git a/rust/kernel/io_buffer.rs b/rust/kernel/io_buffer.rs
new file mode 100644
index 00000000000..ccecc4763ac
--- /dev/null
+++ b/rust/kernel/io_buffer.rs
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Buffers used in IO.
+
+use crate::Result;
+use alloc::vec::Vec;
+use core::mem::{size_of, MaybeUninit};
+
+/// Represents a buffer to be read from during IO.
+pub trait IoBufferReader {
+    /// Returns the number of bytes left to be read from the io buffer.
+    ///
+    /// Note that even reading less than this number of bytes may fail.
+    fn len(&self) -> usize;
+
+    /// Returns `true` if no data is available in the io buffer.
+    fn is_empty(&self) -> bool {
+        self.len() == 0
+    }
+
+    /// Reads raw data from the io buffer into a raw kernel buffer.
+    ///
+    /// # Safety
+    ///
+    /// The output buffer must be valid.
+    unsafe fn read_raw(&mut self, out: *mut u8, len: usize) -> Result;
+
+    /// Reads all data remaining in the io buffer.
+    ///
+    /// Returns `EFAULT` if the address does not currently point to mapped, readable memory.
+    fn read_all(&mut self) -> Result<Vec<u8>> {
+        let mut data = Vec::<u8>::new();
+        data.try_resize(self.len(), 0)?;
+
+        // SAFETY: The output buffer is valid as we just allocated it.
+        unsafe { self.read_raw(data.as_mut_ptr(), data.len())? };
+        Ok(data)
+    }
+
+    /// Reads a byte slice from the io buffer.
+    ///
+    /// Returns `EFAULT` if the byte slice is bigger than the remaining size of the user slice or
+    /// if the address does not currently point to mapped, readable memory.
+    fn read_slice(&mut self, data: &mut [u8]) -> Result {
+        // SAFETY: The output buffer is valid as it's coming from a live reference.
+        unsafe { self.read_raw(data.as_mut_ptr(), data.len()) }
+    }
+
+    /// Reads the contents of a plain old data (POD) type from the io buffer.
+    fn read<T: ReadableFromBytes>(&mut self) -> Result<T> {
+        let mut out = MaybeUninit::<T>::uninit();
+        // SAFETY: The buffer is valid as it was just allocated.
+        unsafe { self.read_raw(out.as_mut_ptr() as _, size_of::<T>()) }?;
+        // SAFETY: We just initialised the data.
+        Ok(unsafe { out.assume_init() })
+    }
+}
+
+/// Represents a buffer to be written to during IO.
+pub trait IoBufferWriter {
+    /// Returns the number of bytes left to be written into the io buffer.
+    ///
+    /// Note that even writing less than this number of bytes may fail.
+    fn len(&self) -> usize;
+
+    /// Returns `true` if the io buffer cannot hold any additional data.
+    fn is_empty(&self) -> bool {
+        self.len() == 0
+    }
+
+    /// Writes zeroes to the io buffer.
+    ///
+    /// Differently from the other write functions, `clear` will zero as much as it can and update
+    /// the writer internal state to reflect this. It will, however, return an error if it cannot
+    /// clear `len` bytes.
+    ///
+    /// For example, if a caller requests that 100 bytes be cleared but a segfault happens after
+    /// 20 bytes, then EFAULT is returned and the writer is advanced by 20 bytes.
+    fn clear(&mut self, len: usize) -> Result;
+
+    /// Writes a byte slice into the io buffer.
+    ///
+    /// Returns `EFAULT` if the byte slice is bigger than the remaining size of the io buffer or if
+    /// the address does not currently point to mapped, writable memory.
+    fn write_slice(&mut self, data: &[u8]) -> Result {
+        // SAFETY: The input buffer is valid as it's coming from a live reference.
+        unsafe { self.write_raw(data.as_ptr(), data.len()) }
+    }
+
+    /// Writes raw data to the io buffer from a raw kernel buffer.
+    ///
+    /// # Safety
+    ///
+    /// The input buffer must be valid.
+    unsafe fn write_raw(&mut self, data: *const u8, len: usize) -> Result;
+
+    /// Writes the contents of the given data into the io buffer.
+    fn write<T: WritableToBytes>(&mut self, data: &T) -> Result {
+        // SAFETY: The input buffer is valid as it's coming from a live
+        // reference to a type that implements `WritableToBytes`.
+        unsafe { self.write_raw(data as *const T as _, size_of::<T>()) }
+    }
+}
+
+/// Specifies that a type is safely readable from byte slices.
+///
+/// Not all types can be safely read from byte slices; examples from
+/// <https://doc.rust-lang.org/reference/behavior-considered-undefined.html> include `bool`
+/// that must be either `0` or `1`, and `char` that cannot be a surrogate or above `char::MAX`.
+///
+/// # Safety
+///
+/// Implementers must ensure that the type is made up only of types that can be safely read from
+/// arbitrary byte sequences (e.g., `u32`, `u64`, etc.).
+pub unsafe trait ReadableFromBytes {}
+
+// SAFETY: All bit patterns are acceptable values of the types below.
+unsafe impl ReadableFromBytes for u8 {}
+unsafe impl ReadableFromBytes for u16 {}
+unsafe impl ReadableFromBytes for u32 {}
+unsafe impl ReadableFromBytes for u64 {}
+unsafe impl ReadableFromBytes for usize {}
+unsafe impl ReadableFromBytes for i8 {}
+unsafe impl ReadableFromBytes for i16 {}
+unsafe impl ReadableFromBytes for i32 {}
+unsafe impl ReadableFromBytes for i64 {}
+unsafe impl ReadableFromBytes for isize {}
+
+/// Specifies that a type is safely writable to byte slices.
+///
+/// This means that we don't read undefined values (which leads to UB) in preparation for writing
+/// to the byte slice. It also ensures that no potentially sensitive information is leaked into the
+/// byte slices.
+///
+/// # Safety
+///
+/// A type must not include padding bytes and must be fully initialised to safely implement
+/// [`WritableToBytes`] (i.e., it doesn't contain [`MaybeUninit`] fields). A composition of
+/// writable types in a structure is not necessarily writable because it may result in padding
+/// bytes.
+pub unsafe trait WritableToBytes {}
+
+// SAFETY: Initialised instances of the following types have no uninitialised portions.
+unsafe impl WritableToBytes for u8 {}
+unsafe impl WritableToBytes for u16 {}
+unsafe impl WritableToBytes for u32 {}
+unsafe impl WritableToBytes for u64 {}
+unsafe impl WritableToBytes for usize {}
+unsafe impl WritableToBytes for i8 {}
+unsafe impl WritableToBytes for i16 {}
+unsafe impl WritableToBytes for i32 {}
+unsafe impl WritableToBytes for i64 {}
+unsafe impl WritableToBytes for isize {}
diff --git a/rust/kernel/iov_iter.rs b/rust/kernel/iov_iter.rs
new file mode 100644
index 00000000000..d778e1ac976
--- /dev/null
+++ b/rust/kernel/iov_iter.rs
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! IO vector iterators.
+//!
+//! C header: [`include/linux/uio.h`](../../../../include/linux/uio.h)
+
+use crate::{
+    bindings, c_types,
+    error::Error,
+    io_buffer::{IoBufferReader, IoBufferWriter},
+    Result,
+};
+
+extern "C" {
+    fn rust_helper_copy_to_iter(
+        addr: *const c_types::c_void,
+        bytes: usize,
+        i: *mut bindings::iov_iter,
+    ) -> usize;
+
+    fn rust_helper_copy_from_iter(
+        addr: *mut c_types::c_void,
+        bytes: usize,
+        i: *mut bindings::iov_iter,
+    ) -> usize;
+}
+
+/// Wraps the kernel's `struct iov_iter`.
+///
+/// # Invariants
+///
+/// The pointer `IovIter::ptr` is non-null and valid.
+pub struct IovIter {
+    ptr: *mut bindings::iov_iter,
+}
+
+impl IovIter {
+    fn common_len(&self) -> usize {
+        // SAFETY: `IovIter::ptr` is guaranteed to be valid by the type invariants.
+        unsafe { (*self.ptr).count }
+    }
+
+    /// Constructs a new [`struct iov_iter`] wrapper.
+    ///
+    /// # Safety
+    ///
+    /// The pointer `ptr` must be non-null and valid for the lifetime of the object.
+    pub(crate) unsafe fn from_ptr(ptr: *mut bindings::iov_iter) -> Self {
+        // INVARIANTS: the safety contract ensures the type invariant will hold.
+        Self { ptr }
+    }
+}
+
+impl IoBufferWriter for IovIter {
+    fn len(&self) -> usize {
+        self.common_len()
+    }
+
+    fn clear(&mut self, mut len: usize) -> Result {
+        while len > 0 {
+            // SAFETY: `IovIter::ptr` is guaranteed to be valid by the type invariants.
+            let written = unsafe { bindings::iov_iter_zero(len, self.ptr) };
+            if written == 0 {
+                return Err(Error::EFAULT);
+            }
+
+            len -= written;
+        }
+        Ok(())
+    }
+
+    unsafe fn write_raw(&mut self, data: *const u8, len: usize) -> Result {
+        let res = unsafe { rust_helper_copy_to_iter(data as _, len, self.ptr) };
+        if res != len {
+            Err(Error::EFAULT)
+        } else {
+            Ok(())
+        }
+    }
+}
+
+impl IoBufferReader for IovIter {
+    fn len(&self) -> usize {
+        self.common_len()
+    }
+
+    unsafe fn read_raw(&mut self, out: *mut u8, len: usize) -> Result {
+        let res = unsafe { rust_helper_copy_from_iter(out as _, len, self.ptr) };
+        if res != len {
+            Err(Error::EFAULT)
+        } else {
+            Ok(())
+        }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
new file mode 100644
index 00000000000..86c580fd7f6
--- /dev/null
+++ b/rust/kernel/lib.rs
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! The `kernel` crate.
+//!
+//! This crate contains the kernel APIs that have been ported or wrapped for
+//! usage by Rust code in the kernel and is shared by all of them.
+//!
+//! In other words, all the rest of the Rust code in the kernel (e.g. kernel
+//! modules written in Rust) depends on [`core`], [`alloc`] and this crate.
+//!
+//! If you need a kernel C API that is not ported or wrapped yet here, then
+//! do so first instead of bypassing this crate.
+
+#![no_std]
+#![feature(
+    allocator_api,
+    alloc_error_handler,
+    associated_type_defaults,
+    const_fn_trait_bound,
+    const_mut_refs,
+    const_panic,
+    const_raw_ptr_deref,
+    const_unreachable_unchecked,
+    receiver_trait,
+    try_reserve
+)]
+
+// Ensure conditional compilation based on the kernel configuration works;
+// otherwise we may silently break things like initcall handling.
+#[cfg(not(CONFIG_RUST))]
+compile_error!("Missing kernel configuration for conditional compilation");
+
+#[cfg(not(test))]
+#[cfg(not(testlib))]
+mod allocator;
+
+#[doc(hidden)]
+pub mod bindings;
+
+pub mod buffer;
+pub mod c_types;
+pub mod chrdev;
+mod error;
+pub mod file;
+pub mod file_operations;
+pub mod miscdev;
+pub mod pages;
+pub mod security;
+pub mod str;
+pub mod task;
+pub mod traits;
+
+pub mod linked_list;
+mod raw_list;
+pub mod rbtree;
+
+#[doc(hidden)]
+pub mod module_param;
+
+mod build_assert;
+pub mod prelude;
+pub mod print;
+pub mod random;
+mod static_assert;
+pub mod sync;
+
+#[cfg(CONFIG_SYSCTL)]
+pub mod sysctl;
+
+pub mod io_buffer;
+pub mod iov_iter;
+pub mod of;
+pub mod platdev;
+mod types;
+pub mod user_ptr;
+
+#[doc(hidden)]
+pub use build_error::build_error;
+
+pub use crate::error::{Error, Result};
+pub use crate::types::{Mode, ScopeGuard};
+
+/// Page size defined in terms of the `PAGE_SHIFT` macro from C.
+///
+/// [`PAGE_SHIFT`]: ../../../include/asm-generic/page.h
+pub const PAGE_SIZE: usize = 1 << bindings::PAGE_SHIFT;
+
+/// Prefix to appear before log messages printed from within the kernel crate.
+const __LOG_PREFIX: &[u8] = b"rust_kernel\0";
+
+/// The top level entrypoint to implementing a kernel module.
+///
+/// For any teardown or cleanup operations, your type may implement [`Drop`].
+pub trait KernelModule: Sized + Sync {
+    /// Called at module initialization time.
+    ///
+    /// Use this method to perform whatever setup or registration your module
+    /// should do.
+    ///
+    /// Equivalent to the `module_init` macro in the C API.
+    fn init() -> Result<Self>;
+}
+
+/// Equivalent to `THIS_MODULE` in the C API.
+///
+/// C header: `include/linux/export.h`
+pub struct ThisModule(*mut bindings::module);
+
+// SAFETY: `THIS_MODULE` may be used from all threads within a module.
+unsafe impl Sync for ThisModule {}
+
+impl ThisModule {
+    /// Creates a [`ThisModule`] given the `THIS_MODULE` pointer.
+    ///
+    /// # Safety
+    ///
+    /// The pointer must be equal to the right `THIS_MODULE`.
+    pub const unsafe fn from_ptr(ptr: *mut bindings::module) -> ThisModule {
+        ThisModule(ptr)
+    }
+
+    /// Locks the module parameters to access them.
+    ///
+    /// Returns a [`KParamGuard`] that will release the lock when dropped.
+    pub fn kernel_param_lock(&self) -> KParamGuard<'_> {
+        // SAFETY: `kernel_param_lock` will check if the pointer is null and
+        // use the built-in mutex in that case.
+        #[cfg(CONFIG_SYSFS)]
+        unsafe {
+            bindings::kernel_param_lock(self.0)
+        }
+
+        KParamGuard { this_module: self }
+    }
+}
+
+/// Scoped lock on the kernel parameters of [`ThisModule`].
+///
+/// Lock will be released when this struct is dropped.
+pub struct KParamGuard<'a> {
+    this_module: &'a ThisModule,
+}
+
+#[cfg(CONFIG_SYSFS)]
+impl<'a> Drop for KParamGuard<'a> {
+    fn drop(&mut self) {
+        // SAFETY: `kernel_param_lock` will check if the pointer is null and
+        // use the built-in mutex in that case. The existance of `self`
+        // guarantees that the lock is held.
+        unsafe { bindings::kernel_param_unlock(self.this_module.0) }
+    }
+}
+
+/// Calculates the offset of a field from the beginning of the struct it belongs to.
+///
+/// # Example
+///
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::offset_of;
+/// struct Test {
+///     a: u64,
+///     b: u32,
+/// }
+///
+/// fn test() {
+///     // This prints `8`.
+///     pr_info!("{}\n", offset_of!(Test, b));
+/// }
+/// ```
+#[macro_export]
+macro_rules! offset_of {
+    ($type:ty, $($f:tt)*) => {{
+        let tmp = core::mem::MaybeUninit::<$type>::uninit();
+        let outer = tmp.as_ptr();
+        // To avoid warnings when nesting `unsafe` blocks.
+        #[allow(unused_unsafe)]
+        // SAFETY: The pointer is valid and aligned, just not initialised; `addr_of` ensures that
+        // we don't actually read from `outer` (which would be UB) nor create an intermediate
+        // reference.
+        let inner = unsafe { core::ptr::addr_of!((*outer).$($f)*) } as *const u8;
+        // To avoid warnings when nesting `unsafe` blocks.
+        #[allow(unused_unsafe)]
+        // SAFETY: The two pointers are within the same allocation block.
+        unsafe { inner.offset_from(outer as *const u8) }
+    }}
+}
+
+/// Produces a pointer to an object from a pointer to one of its fields.
+///
+/// # Safety
+///
+/// Callers must ensure that the pointer to the field is in fact a pointer to the specified field,
+/// as opposed to a pointer to another object of the same type.
+///
+/// # Example
+///
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::container_of;
+/// struct Test {
+///     a: u64,
+///     b: u32,
+/// }
+///
+/// fn test() {
+///     let test = Test { a: 10, b: 20 };
+///     let b_ptr = &test.b;
+///     let test_alias = unsafe { container_of!(b_ptr, Test, b) };
+///     // This prints `true`.
+///     pr_info!("{}\n", core::ptr::eq(&test, test_alias));
+/// }
+/// ```
+#[macro_export]
+macro_rules! container_of {
+    ($ptr:expr, $type:ty, $($f:tt)*) => {{
+        let offset = $crate::offset_of!($type, $($f)*);
+        unsafe { ($ptr as *const _ as *const u8).offset(-offset) as *const $type }
+    }}
+}
diff --git a/rust/kernel/linked_list.rs b/rust/kernel/linked_list.rs
new file mode 100644
index 00000000000..d57bf1b881a
--- /dev/null
+++ b/rust/kernel/linked_list.rs
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Linked lists.
+//!
+//! TODO: This module is a work in progress.
+
+use alloc::{boxed::Box, sync::Arc};
+use core::ptr::NonNull;
+
+pub use crate::raw_list::{Cursor, GetLinks, Links};
+use crate::{raw_list, raw_list::RawList};
+
+// TODO: Use the one from `kernel::file_operations::PointerWrapper` instead.
+/// Wraps an object to be inserted in a linked list.
+pub trait Wrapper<T: ?Sized> {
+    /// Converts the wrapped object into a pointer that represents it.
+    fn into_pointer(self) -> NonNull<T>;
+
+    /// Converts the object back from the pointer representation.
+    ///
+    /// # Safety
+    ///
+    /// The passed pointer must come from a previous call to [`Wrapper::into_pointer()`].
+    unsafe fn from_pointer(ptr: NonNull<T>) -> Self;
+
+    /// Returns a reference to the wrapped object.
+    fn as_ref(&self) -> &T;
+}
+
+impl<T: ?Sized> Wrapper<T> for Box<T> {
+    fn into_pointer(self) -> NonNull<T> {
+        NonNull::new(Box::into_raw(self)).unwrap()
+    }
+
+    unsafe fn from_pointer(ptr: NonNull<T>) -> Self {
+        unsafe { Box::from_raw(ptr.as_ptr()) }
+    }
+
+    fn as_ref(&self) -> &T {
+        AsRef::as_ref(self)
+    }
+}
+
+impl<T: ?Sized> Wrapper<T> for Arc<T> {
+    fn into_pointer(self) -> NonNull<T> {
+        NonNull::new(Arc::into_raw(self) as _).unwrap()
+    }
+
+    unsafe fn from_pointer(ptr: NonNull<T>) -> Self {
+        unsafe { Arc::from_raw(ptr.as_ptr()) }
+    }
+
+    fn as_ref(&self) -> &T {
+        AsRef::as_ref(self)
+    }
+}
+
+impl<T: ?Sized> Wrapper<T> for &T {
+    fn into_pointer(self) -> NonNull<T> {
+        NonNull::from(self)
+    }
+
+    unsafe fn from_pointer(ptr: NonNull<T>) -> Self {
+        unsafe { &*ptr.as_ptr() }
+    }
+
+    fn as_ref(&self) -> &T {
+        self
+    }
+}
+
+/// A descriptor of wrapped list elements.
+pub trait GetLinksWrapped: GetLinks {
+    /// Specifies which wrapper (e.g., `Box` and `Arc`) wraps the list entries.
+    type Wrapped: Wrapper<Self::EntryType>;
+}
+
+impl<T: ?Sized> GetLinksWrapped for Box<T>
+where
+    Box<T>: GetLinks,
+{
+    type Wrapped = Box<<Box<T> as GetLinks>::EntryType>;
+}
+
+impl<T: GetLinks + ?Sized> GetLinks for Box<T> {
+    type EntryType = T::EntryType;
+    fn get_links(data: &Self::EntryType) -> &Links<Self::EntryType> {
+        <T as GetLinks>::get_links(data)
+    }
+}
+
+impl<T: ?Sized> GetLinksWrapped for Arc<T>
+where
+    Arc<T>: GetLinks,
+{
+    type Wrapped = Arc<<Arc<T> as GetLinks>::EntryType>;
+}
+
+impl<T: GetLinks + ?Sized> GetLinks for Arc<T> {
+    type EntryType = T::EntryType;
+    fn get_links(data: &Self::EntryType) -> &Links<Self::EntryType> {
+        <T as GetLinks>::get_links(data)
+    }
+}
+
+/// A linked list.
+///
+/// Elements in the list are wrapped and ownership is transferred to the list while the element is
+/// in the list.
+pub struct List<G: GetLinksWrapped> {
+    list: RawList<G>,
+}
+
+impl<G: GetLinksWrapped> List<G> {
+    /// Constructs a new empty linked list.
+    pub fn new() -> Self {
+        Self {
+            list: RawList::new(),
+        }
+    }
+
+    /// Returns whether the list is empty.
+    pub fn is_empty(&self) -> bool {
+        self.list.is_empty()
+    }
+
+    /// Adds the given object to the end (back) of the list.
+    ///
+    /// It is dropped if it's already on this (or another) list; this can happen for
+    /// reference-counted objects, so dropping means decrementing the reference count.
+    pub fn push_back(&mut self, data: G::Wrapped) {
+        let ptr = data.into_pointer();
+
+        // SAFETY: We took ownership of the entry, so it is safe to insert it.
+        if !unsafe { self.list.push_back(ptr.as_ref()) } {
+            // If insertion failed, rebuild object so that it can be freed.
+            // SAFETY: We just called `into_pointer` above.
+            unsafe { G::Wrapped::from_pointer(ptr) };
+        }
+    }
+
+    /// Inserts the given object after `existing`.
+    ///
+    /// It is dropped if it's already on this (or another) list; this can happen for
+    /// reference-counted objects, so dropping means decrementing the reference count.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `existing` points to a valid entry that is on the list.
+    pub unsafe fn insert_after(&mut self, existing: NonNull<G::EntryType>, data: G::Wrapped) {
+        let ptr = data.into_pointer();
+        let entry = unsafe { &*existing.as_ptr() };
+        if unsafe { !self.list.insert_after(entry, ptr.as_ref()) } {
+            // If insertion failed, rebuild object so that it can be freed.
+            unsafe { G::Wrapped::from_pointer(ptr) };
+        }
+    }
+
+    /// Removes the given entry.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `data` is either on this list or in no list. It being on another
+    /// list leads to memory unsafety.
+    pub unsafe fn remove(&mut self, data: &G::Wrapped) -> Option<G::Wrapped> {
+        let entry_ref = Wrapper::as_ref(data);
+        if unsafe { self.list.remove(entry_ref) } {
+            Some(unsafe { G::Wrapped::from_pointer(NonNull::from(entry_ref)) })
+        } else {
+            None
+        }
+    }
+
+    /// Removes the element currently at the front of the list and returns it.
+    ///
+    /// Returns `None` if the list is empty.
+    pub fn pop_front(&mut self) -> Option<G::Wrapped> {
+        let front = self.list.pop_front()?;
+        // SAFETY: Elements on the list were inserted after a call to `into_pointer `.
+        Some(unsafe { G::Wrapped::from_pointer(front) })
+    }
+
+    /// Returns a cursor starting on the first (front) element of the list.
+    pub fn cursor_front(&self) -> Cursor<'_, G> {
+        self.list.cursor_front()
+    }
+
+    /// Returns a mutable cursor starting on the first (front) element of the list.
+    pub fn cursor_front_mut(&mut self) -> CursorMut<'_, G> {
+        CursorMut::new(self.list.cursor_front_mut())
+    }
+}
+
+impl<G: GetLinksWrapped> Default for List<G> {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl<G: GetLinksWrapped> Drop for List<G> {
+    fn drop(&mut self) {
+        while self.pop_front().is_some() {}
+    }
+}
+
+/// A list cursor that allows traversing a linked list and inspecting & mutating elements.
+pub struct CursorMut<'a, G: GetLinksWrapped> {
+    cursor: raw_list::CursorMut<'a, G>,
+}
+
+impl<'a, G: GetLinksWrapped> CursorMut<'a, G> {
+    fn new(cursor: raw_list::CursorMut<'a, G>) -> Self {
+        Self { cursor }
+    }
+
+    /// Returns the element the cursor is currently positioned on.
+    pub fn current(&mut self) -> Option<&mut G::EntryType> {
+        self.cursor.current()
+    }
+
+    /// Removes the element the cursor is currently positioned on.
+    ///
+    /// After removal, it advances the cursor to the next element.
+    pub fn remove_current(&mut self) -> Option<G::Wrapped> {
+        let ptr = self.cursor.remove_current()?;
+
+        // SAFETY: Elements on the list were inserted after a call to `into_pointer `.
+        Some(unsafe { G::Wrapped::from_pointer(ptr) })
+    }
+
+    /// Returns the element immediately after the one the cursor is positioned on.
+    pub fn peek_next(&mut self) -> Option<&mut G::EntryType> {
+        self.cursor.peek_next()
+    }
+
+    /// Returns the element immediately before the one the cursor is positioned on.
+    pub fn peek_prev(&mut self) -> Option<&mut G::EntryType> {
+        self.cursor.peek_prev()
+    }
+
+    /// Moves the cursor to the next element.
+    pub fn move_next(&mut self) {
+        self.cursor.move_next();
+    }
+}
diff --git a/rust/kernel/miscdev.rs b/rust/kernel/miscdev.rs
new file mode 100644
index 00000000000..e4d94d7416e
--- /dev/null
+++ b/rust/kernel/miscdev.rs
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Miscellaneous devices.
+//!
+//! C header: [`include/linux/miscdevice.h`](../../../../include/linux/miscdevice.h)
+//!
+//! Reference: <https://www.kernel.org/doc/html/latest/driver-api/misc_devices.html>
+
+use crate::bindings;
+use crate::error::{Error, Result};
+use crate::file_operations::{FileOpenAdapter, FileOpener, FileOperationsVtable};
+use crate::str::CStr;
+use alloc::boxed::Box;
+use core::marker::PhantomPinned;
+use core::pin::Pin;
+
+/// A registration of a miscellaneous device.
+pub struct Registration<T: Sync = ()> {
+    registered: bool,
+    mdev: bindings::miscdevice,
+    _pin: PhantomPinned,
+
+    /// Context initialised on construction and made available to all file instances on
+    /// [`FileOpener::open`].
+    pub context: T,
+}
+
+impl<T: Sync> Registration<T> {
+    /// Creates a new [`Registration`] but does not register it yet.
+    ///
+    /// It is allowed to move.
+    pub fn new(context: T) -> Self {
+        Self {
+            registered: false,
+            mdev: bindings::miscdevice::default(),
+            _pin: PhantomPinned,
+            context,
+        }
+    }
+
+    /// Registers a miscellaneous device.
+    ///
+    /// Returns a pinned heap-allocated representation of the registration.
+    pub fn new_pinned<F: FileOpener<T>>(
+        name: &'static CStr,
+        minor: Option<i32>,
+        context: T,
+    ) -> Result<Pin<Box<Self>>> {
+        let mut r = Pin::from(Box::try_new(Self::new(context))?);
+        r.as_mut().register::<F>(name, minor)?;
+        Ok(r)
+    }
+
+    /// Registers a miscellaneous device with the rest of the kernel.
+    ///
+    /// It must be pinned because the memory block that represents the registration is
+    /// self-referential. If a minor is not given, the kernel allocates a new one if possible.
+    pub fn register<F: FileOpener<T>>(
+        self: Pin<&mut Self>,
+        name: &'static CStr,
+        minor: Option<i32>,
+    ) -> Result {
+        // SAFETY: We must ensure that we never move out of `this`.
+        let this = unsafe { self.get_unchecked_mut() };
+        if this.registered {
+            // Already registered.
+            return Err(Error::EINVAL);
+        }
+
+        // SAFETY: The adapter is compatible with `misc_register`.
+        this.mdev.fops = unsafe { FileOperationsVtable::<Self, F>::build() };
+        this.mdev.name = name.as_char_ptr();
+        this.mdev.minor = minor.unwrap_or(bindings::MISC_DYNAMIC_MINOR as i32);
+
+        let ret = unsafe { bindings::misc_register(&mut this.mdev) };
+        if ret < 0 {
+            return Err(Error::from_kernel_errno(ret));
+        }
+        this.registered = true;
+        Ok(())
+    }
+}
+
+impl<T: Sync> FileOpenAdapter for Registration<T> {
+    type Arg = T;
+
+    unsafe fn convert(_inode: *mut bindings::inode, file: *mut bindings::file) -> *const Self::Arg {
+        // TODO: `SAFETY` comment required here even if `unsafe` is not present,
+        // because `container_of!` hides it. Ideally we would not allow
+        // `unsafe` code as parameters to macros.
+        let reg = crate::container_of!((*file).private_data, Self, mdev);
+        unsafe { &(*reg).context }
+    }
+}
+
+// SAFETY: The only method is `register()`, which requires a (pinned) mutable `Registration`, so it
+// is safe to pass `&Registration` to multiple threads because it offers no interior mutability,
+// except maybe through `Registration::context`, but it is itself `Sync`.
+unsafe impl<T: Sync> Sync for Registration<T> {}
+
+// SAFETY: All functions work from any thread. So as long as the `Registration::context` is
+// `Send`, so is `Registration<T>`. `T` needs to be `Sync` because it's a requirement of
+// `Registration<T>`.
+unsafe impl<T: Send + Sync> Send for Registration<T> {}
+
+impl<T: Sync> Drop for Registration<T> {
+    /// Removes the registration from the kernel if it has completed successfully before.
+    fn drop(&mut self) {
+        if self.registered {
+            unsafe { bindings::misc_deregister(&mut self.mdev) }
+        }
+    }
+}
diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
new file mode 100644
index 00000000000..a588449c41f
--- /dev/null
+++ b/rust/kernel/module_param.rs
@@ -0,0 +1,497 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Types for module parameters.
+//!
+//! C header: [`include/linux/moduleparam.h`](../../../include/linux/moduleparam.h)
+
+use crate::str::CStr;
+use core::fmt::Write;
+
+/// Types that can be used for module parameters.
+///
+/// Note that displaying the type in `sysfs` will fail if
+/// [`alloc::string::ToString::to_string`] (as implemented through the
+/// [`core::fmt::Display`] trait) writes more than [`PAGE_SIZE`]
+/// bytes (including an additional null terminator).
+///
+/// [`PAGE_SIZE`]: `crate::PAGE_SIZE`
+pub trait ModuleParam: core::fmt::Display + core::marker::Sized {
+    /// The `ModuleParam` will be used by the kernel module through this type.
+    ///
+    /// This may differ from `Self` if, for example, `Self` needs to track
+    /// ownership without exposing it or allocate extra space for other possible
+    /// parameter values. See [`StringParam`] or [`ArrayParam`] for examples.
+    type Value: ?Sized;
+
+    /// Whether the parameter is allowed to be set without an argument.
+    ///
+    /// Setting this to `true` allows the parameter to be passed without an
+    /// argument (e.g. just `module.param` instead of `module.param=foo`).
+    const NOARG_ALLOWED: bool;
+
+    /// Convert a parameter argument into the parameter value.
+    ///
+    /// `None` should be returned when parsing of the argument fails.
+    /// `arg == None` indicates that the parameter was passed without an
+    /// argument. If `NOARG_ALLOWED` is set to `false` then `arg` is guaranteed
+    /// to always be `Some(_)`.
+    ///
+    /// Parameters passed at boot time will be set before [`kmalloc`] is
+    /// available (even if the module is loaded at a later time). However, in
+    /// this case, the argument buffer will be valid for the entire lifetime of
+    /// the kernel. So implementations of this method which need to allocate
+    /// should first check that the allocator is available (with
+    /// [`crate::bindings::slab_is_available`]) and when it is not available
+    /// provide an alternative implementation which doesn't allocate. In cases
+    /// where the allocator is not available it is safe to save references to
+    /// `arg` in `Self`, but in other cases a copy should be made.
+    ///
+    /// [`kmalloc`]: ../../../include/linux/slab.h
+    fn try_from_param_arg(arg: Option<&'static [u8]>) -> Option<Self>;
+
+    /// Get the current value of the parameter for use in the kernel module.
+    ///
+    /// This function should not be used directly. Instead use the wrapper
+    /// `read` which will be generated by [`macros::module`].
+    fn value(&self) -> &Self::Value;
+
+    /// Set the module parameter from a string.
+    ///
+    /// Used to set the parameter value when loading the module or when set
+    /// through `sysfs`.
+    ///
+    /// # Safety
+    ///
+    /// If `val` is non-null then it must point to a valid null-terminated
+    /// string. The `arg` field of `param` must be an instance of `Self`.
+    unsafe extern "C" fn set_param(
+        val: *const crate::c_types::c_char,
+        param: *const crate::bindings::kernel_param,
+    ) -> crate::c_types::c_int {
+        let arg = if val.is_null() {
+            None
+        } else {
+            Some(unsafe { CStr::from_char_ptr(val).as_bytes() })
+        };
+        match Self::try_from_param_arg(arg) {
+            Some(new_value) => {
+                let old_value = unsafe { (*param).__bindgen_anon_1.arg as *mut Self };
+                let _ = unsafe { core::ptr::replace(old_value, new_value) };
+                0
+            }
+            None => crate::error::Error::EINVAL.to_kernel_errno(),
+        }
+    }
+
+    /// Write a string representation of the current parameter value to `buf`.
+    ///
+    /// Used for displaying the current parameter value in `sysfs`.
+    ///
+    /// # Safety
+    ///
+    /// `buf` must be a buffer of length at least `kernel::PAGE_SIZE` that is
+    /// writeable. The `arg` field of `param` must be an instance of `Self`.
+    unsafe extern "C" fn get_param(
+        buf: *mut crate::c_types::c_char,
+        param: *const crate::bindings::kernel_param,
+    ) -> crate::c_types::c_int {
+        let slice = unsafe { core::slice::from_raw_parts_mut(buf as *mut u8, crate::PAGE_SIZE) };
+        let mut buf = crate::buffer::Buffer::new(slice);
+        match unsafe { write!(buf, "{}\0", *((*param).__bindgen_anon_1.arg as *mut Self)) } {
+            Err(_) => crate::error::Error::EINVAL.to_kernel_errno(),
+            Ok(()) => buf.bytes_written() as crate::c_types::c_int,
+        }
+    }
+
+    /// Drop the parameter.
+    ///
+    /// Called when unloading a module.
+    ///
+    /// # Safety
+    ///
+    /// The `arg` field of `param` must be an instance of `Self`.
+    unsafe extern "C" fn free(arg: *mut crate::c_types::c_void) {
+        unsafe { core::ptr::drop_in_place(arg as *mut Self) };
+    }
+}
+
+/// Trait for parsing integers.
+///
+/// Strings begining with `0x`, `0o`, or `0b` are parsed as hex, octal, or
+/// binary respectively. Strings beginning with `0` otherwise are parsed as
+/// octal. Anything else is parsed as decimal. A leading `+` or `-` is also
+/// permitted. Any string parsed by [`kstrtol()`] or [`kstrtoul()`] will be
+/// successfully parsed.
+///
+/// [`kstrtol()`]: https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#c.kstrtol
+/// [`kstrtoul()`]: https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#c.kstrtoul
+trait ParseInt: Sized {
+    fn from_str_radix(src: &str, radix: u32) -> Result<Self, core::num::ParseIntError>;
+    fn checked_neg(self) -> Option<Self>;
+
+    fn from_str_unsigned(src: &str) -> Result<Self, core::num::ParseIntError> {
+        let (radix, digits) = if let Some(n) = src.strip_prefix("0x") {
+            (16, n)
+        } else if let Some(n) = src.strip_prefix("0X") {
+            (16, n)
+        } else if let Some(n) = src.strip_prefix("0o") {
+            (8, n)
+        } else if let Some(n) = src.strip_prefix("0O") {
+            (8, n)
+        } else if let Some(n) = src.strip_prefix("0b") {
+            (2, n)
+        } else if let Some(n) = src.strip_prefix("0B") {
+            (2, n)
+        } else if src.starts_with('0') {
+            (8, src)
+        } else {
+            (10, src)
+        };
+        Self::from_str_radix(digits, radix)
+    }
+
+    fn from_str(src: &str) -> Option<Self> {
+        match src.bytes().next() {
+            None => None,
+            Some(b'-') => Self::from_str_unsigned(&src[1..]).ok()?.checked_neg(),
+            Some(b'+') => Some(Self::from_str_unsigned(&src[1..]).ok()?),
+            Some(_) => Some(Self::from_str_unsigned(src).ok()?),
+        }
+    }
+}
+
+macro_rules! impl_parse_int {
+    ($ty:ident) => {
+        impl ParseInt for $ty {
+            fn from_str_radix(src: &str, radix: u32) -> Result<Self, core::num::ParseIntError> {
+                $ty::from_str_radix(src, radix)
+            }
+
+            fn checked_neg(self) -> Option<Self> {
+                self.checked_neg()
+            }
+        }
+    };
+}
+
+impl_parse_int!(i8);
+impl_parse_int!(u8);
+impl_parse_int!(i16);
+impl_parse_int!(u16);
+impl_parse_int!(i32);
+impl_parse_int!(u32);
+impl_parse_int!(i64);
+impl_parse_int!(u64);
+impl_parse_int!(isize);
+impl_parse_int!(usize);
+
+macro_rules! impl_module_param {
+    ($ty:ident) => {
+        impl ModuleParam for $ty {
+            type Value = $ty;
+
+            const NOARG_ALLOWED: bool = false;
+
+            fn try_from_param_arg(arg: Option<&'static [u8]>) -> Option<Self> {
+                let bytes = arg?;
+                let utf8 = core::str::from_utf8(bytes).ok()?;
+                <$ty as crate::module_param::ParseInt>::from_str(utf8)
+            }
+
+            fn value(&self) -> &Self::Value {
+                self
+            }
+        }
+    };
+}
+
+#[doc(hidden)]
+#[macro_export]
+/// Generate a static [`kernel_param_ops`](../../../include/linux/moduleparam.h) struct.
+///
+/// # Example
+/// ```ignore
+/// make_param_ops!(
+///     /// Documentation for new param ops.
+///     PARAM_OPS_MYTYPE, // Name for the static.
+///     MyType // A type which implements [`ModuleParam`].
+/// );
+/// ```
+macro_rules! make_param_ops {
+    ($ops:ident, $ty:ty) => {
+        $crate::make_param_ops!(
+            #[doc=""]
+            $ops,
+            $ty
+        );
+    };
+    ($(#[$meta:meta])* $ops:ident, $ty:ty) => {
+        $(#[$meta])*
+        ///
+        /// Static [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+        /// struct generated by [`make_param_ops`].
+        pub static $ops: $crate::bindings::kernel_param_ops = $crate::bindings::kernel_param_ops {
+            flags: if <$ty as $crate::module_param::ModuleParam>::NOARG_ALLOWED {
+                $crate::bindings::KERNEL_PARAM_OPS_FL_NOARG
+            } else {
+                0
+            },
+            set: Some(<$ty as $crate::module_param::ModuleParam>::set_param),
+            get: Some(<$ty as $crate::module_param::ModuleParam>::get_param),
+            free: Some(<$ty as $crate::module_param::ModuleParam>::free),
+        };
+    };
+}
+
+impl_module_param!(i8);
+impl_module_param!(u8);
+impl_module_param!(i16);
+impl_module_param!(u16);
+impl_module_param!(i32);
+impl_module_param!(u32);
+impl_module_param!(i64);
+impl_module_param!(u64);
+impl_module_param!(isize);
+impl_module_param!(usize);
+
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`i8`].
+    PARAM_OPS_I8,
+    i8
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`u8`].
+    PARAM_OPS_U8,
+    u8
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`i16`].
+    PARAM_OPS_I16,
+    i16
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`u16`].
+    PARAM_OPS_U16,
+    u16
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`i32`].
+    PARAM_OPS_I32,
+    i32
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`u32`].
+    PARAM_OPS_U32,
+    u32
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`i64`].
+    PARAM_OPS_I64,
+    i64
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`u64`].
+    PARAM_OPS_U64,
+    u64
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`isize`].
+    PARAM_OPS_ISIZE,
+    isize
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`usize`].
+    PARAM_OPS_USIZE,
+    usize
+);
+
+impl ModuleParam for bool {
+    type Value = bool;
+
+    const NOARG_ALLOWED: bool = true;
+
+    fn try_from_param_arg(arg: Option<&'static [u8]>) -> Option<Self> {
+        match arg {
+            None => Some(true),
+            Some(b"y") | Some(b"Y") | Some(b"1") | Some(b"true") => Some(true),
+            Some(b"n") | Some(b"N") | Some(b"0") | Some(b"false") => Some(false),
+            _ => None,
+        }
+    }
+
+    fn value(&self) -> &Self::Value {
+        self
+    }
+}
+
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`bool`].
+    PARAM_OPS_BOOL,
+    bool
+);
+
+/// An array of at __most__ `N` values.
+///
+/// # Invariant
+///
+/// The first `self.used` elements of `self.values` are initialized.
+pub struct ArrayParam<T, const N: usize> {
+    values: [core::mem::MaybeUninit<T>; N],
+    used: usize,
+}
+
+impl<T, const N: usize> ArrayParam<T, { N }> {
+    fn values(&self) -> &[T] {
+        // SAFETY: The invariant maintained by `ArrayParam` allows us to cast
+        // the first `self.used` elements to `T`.
+        unsafe {
+            &*(&self.values[0..self.used] as *const [core::mem::MaybeUninit<T>] as *const [T])
+        }
+    }
+}
+
+impl<T: Copy, const N: usize> ArrayParam<T, { N }> {
+    const fn new() -> Self {
+        // INVARIANT: The first `self.used` elements of `self.values` are
+        // initialized.
+        ArrayParam {
+            values: [core::mem::MaybeUninit::uninit(); N],
+            used: 0,
+        }
+    }
+
+    const fn push(&mut self, val: T) {
+        if self.used < N {
+            // INVARIANT: The first `self.used` elements of `self.values` are
+            // initialized.
+            self.values[self.used] = core::mem::MaybeUninit::new(val);
+            self.used += 1;
+        }
+    }
+
+    /// Create an instance of `ArrayParam` initialized with `vals`.
+    ///
+    /// This function is only meant to be used in the [`module::module`] macro.
+    pub const fn create(vals: &[T]) -> Self {
+        let mut result = ArrayParam::new();
+        let mut i = 0;
+        while i < vals.len() {
+            result.push(vals[i]);
+            i += 1;
+        }
+        result
+    }
+}
+
+impl<T: core::fmt::Display, const N: usize> core::fmt::Display for ArrayParam<T, { N }> {
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        for val in self.values() {
+            write!(f, "{},", val)?;
+        }
+        Ok(())
+    }
+}
+
+impl<T: Copy + core::fmt::Display + ModuleParam, const N: usize> ModuleParam
+    for ArrayParam<T, { N }>
+{
+    type Value = [T];
+
+    const NOARG_ALLOWED: bool = false;
+
+    fn try_from_param_arg(arg: Option<&'static [u8]>) -> Option<Self> {
+        arg.and_then(|args| {
+            let mut result = Self::new();
+            for arg in args.split(|b| *b == b',') {
+                result.push(T::try_from_param_arg(Some(arg))?);
+            }
+            Some(result)
+        })
+    }
+
+    fn value(&self) -> &Self::Value {
+        self.values()
+    }
+}
+
+/// A C-style string parameter.
+///
+/// The Rust version of the [`charp`] parameter. This type is meant to be
+/// used by the [`macros::module`] macro, not handled directly. Instead use the
+/// `read` method generated by that macro.
+///
+/// [`charp`]: ../../../include/linux/moduleparam.h
+pub enum StringParam {
+    /// A borrowed parameter value.
+    ///
+    /// Either the default value (which is static in the module) or borrowed
+    /// from the original argument buffer used to set the value.
+    Ref(&'static [u8]),
+
+    /// A value that was allocated when the parameter was set.
+    ///
+    /// The value needs to be freed when the parameter is reset or the module is
+    /// unloaded.
+    Owned(alloc::vec::Vec<u8>),
+}
+
+impl StringParam {
+    fn bytes(&self) -> &[u8] {
+        match self {
+            StringParam::Ref(bytes) => *bytes,
+            StringParam::Owned(vec) => &vec[..],
+        }
+    }
+}
+
+impl core::fmt::Display for StringParam {
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        let bytes = self.bytes();
+        match core::str::from_utf8(bytes) {
+            Ok(utf8) => write!(f, "{}", utf8),
+            Err(_) => write!(f, "{:?}", bytes),
+        }
+    }
+}
+
+impl ModuleParam for StringParam {
+    type Value = [u8];
+
+    const NOARG_ALLOWED: bool = false;
+
+    fn try_from_param_arg(arg: Option<&'static [u8]>) -> Option<Self> {
+        // SAFETY: It is always safe to call [`slab_is_available`](../../../include/linux/slab.h).
+        let slab_available = unsafe { crate::bindings::slab_is_available() };
+        arg.and_then(|arg| {
+            if slab_available {
+                let mut vec = alloc::vec::Vec::new();
+                vec.try_extend_from_slice(arg).ok()?;
+                Some(StringParam::Owned(vec))
+            } else {
+                Some(StringParam::Ref(arg))
+            }
+        })
+    }
+
+    fn value(&self) -> &Self::Value {
+        self.bytes()
+    }
+}
+
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`StringParam`].
+    PARAM_OPS_STR,
+    StringParam
+);
diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
new file mode 100644
index 00000000000..78aa5956f03
--- /dev/null
+++ b/rust/kernel/of.rs
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Devicetree and Open Firmware abstractions.
+//!
+//! C header: [`include/linux/of_*.h`](../../../../include/linux/of_*.h)
+
+use crate::{bindings, c_types, str::CStr};
+
+use core::ops::Deref;
+use core::ptr;
+
+/// A kernel Open Firmware / devicetree match table.
+///
+/// Can only exist as an `&OfMatchTable` reference (akin to `&str` or
+/// `&Path` in Rust std).
+///
+/// # Invariants
+///
+/// The inner reference points to a sentinel-terminated C array.
+#[repr(transparent)]
+pub struct OfMatchTable(bindings::of_device_id);
+
+impl OfMatchTable {
+    /// Returns the table as a reference to a static lifetime, sentinel-terminated C array.
+    ///
+    /// This is suitable to be coerced into the kernel's `of_match_table` field.
+    pub fn as_ptr(&'static self) -> &'static bindings::of_device_id {
+        // The inner reference points to a sentinel-terminated C array, as per
+        // the type invariant.
+        &self.0
+    }
+}
+
+/// An Open Firmware Match Table that can be constructed at build time.
+///
+/// # Invariants
+///
+/// `sentinel` always contains zeroes.
+#[repr(C)]
+pub struct ConstOfMatchTable<const N: usize> {
+    table: [bindings::of_device_id; N],
+    sentinel: bindings::of_device_id,
+}
+
+impl<const N: usize> ConstOfMatchTable<N> {
+    /// Creates a new Open Firmware Match Table from a list of compatible strings.
+    pub const fn new_const(compatibles: [&'static CStr; N]) -> Self {
+        let mut table = [Self::zeroed_of_device_id(); N];
+        let mut i = 0;
+        while i < N {
+            table[i] = Self::new_of_device_id(compatibles[i]);
+            i += 1;
+        }
+        Self {
+            table,
+            // INVARIANTS: we zero the sentinel here, and never change it
+            // anywhere. Therefore it always contains zeroes.
+            sentinel: Self::zeroed_of_device_id(),
+        }
+    }
+
+    const fn zeroed_of_device_id() -> bindings::of_device_id {
+        bindings::of_device_id {
+            name: [0; 32],
+            type_: [0; 32],
+            compatible: [0; 128],
+            data: ptr::null(),
+        }
+    }
+
+    const fn new_of_device_id(compatible: &'static CStr) -> bindings::of_device_id {
+        let mut id = Self::zeroed_of_device_id();
+        let compatible = compatible.as_bytes_with_nul();
+        let mut i = 0;
+        while i < compatible.len() {
+            // If `compatible` does not fit in `id.compatible`, an
+            // "index out of bounds" build time error will be triggered.
+            id.compatible[i] = compatible[i] as c_types::c_char;
+            i += 1;
+        }
+        id
+    }
+}
+
+impl<const N: usize> Deref for ConstOfMatchTable<N> {
+    type Target = OfMatchTable;
+
+    fn deref(&self) -> &OfMatchTable {
+        // INVARIANTS: `head` points to a sentinel-terminated C array,
+        // as per the `ConstOfMatchTable` type invariant, therefore
+        // `&OfMatchTable`'s inner reference will point to a sentinel-terminated C array.
+        let head = &self.table[0] as *const bindings::of_device_id as *const OfMatchTable;
+
+        // SAFETY: The returned reference must remain valid for the lifetime of `self`.
+        // The raw pointer `head` points to memory inside `self`. So the reference created
+        // from this raw pointer has the same lifetime as `self`.
+        // Therefore this reference remains valid for the lifetime of `self`, and
+        // is safe to return.
+        unsafe { &*head }
+    }
+}
diff --git a/rust/kernel/pages.rs b/rust/kernel/pages.rs
new file mode 100644
index 00000000000..4f45bef09bc
--- /dev/null
+++ b/rust/kernel/pages.rs
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Kernel page allocation and management.
+//!
+//! TODO: This module is a work in progress.
+
+use crate::{
+    bindings, c_types, io_buffer::IoBufferReader, user_ptr::UserSlicePtrReader, Error, Result,
+    PAGE_SIZE,
+};
+use core::{marker::PhantomData, ptr};
+
+extern "C" {
+    #[allow(improper_ctypes)]
+    fn rust_helper_alloc_pages(
+        gfp_mask: bindings::gfp_t,
+        order: c_types::c_uint,
+    ) -> *mut bindings::page;
+
+    #[allow(improper_ctypes)]
+    fn rust_helper_kmap(page: *mut bindings::page) -> *mut c_types::c_void;
+
+    #[allow(improper_ctypes)]
+    fn rust_helper_kunmap(page: *mut bindings::page);
+}
+
+/// A set of physical pages.
+///
+/// `Pages` holds a reference to a set of pages of order `ORDER`. Having the order as a generic
+/// const allows the struct to have the same size as a pointer.
+///
+/// # Invariants
+///
+/// The pointer `Pages::pages` is valid and points to 2^ORDER pages.
+pub struct Pages<const ORDER: u32> {
+    pages: *mut bindings::page,
+}
+
+impl<const ORDER: u32> Pages<ORDER> {
+    /// Allocates a new set of contiguous pages.
+    pub fn new() -> Result<Self> {
+        // TODO: Consider whether we want to allow callers to specify flags.
+        // SAFETY: This only allocates pages. We check that it succeeds in the next statement.
+        let pages = unsafe {
+            rust_helper_alloc_pages(
+                bindings::GFP_KERNEL | bindings::__GFP_ZERO | bindings::__GFP_HIGHMEM,
+                ORDER,
+            )
+        };
+        if pages.is_null() {
+            return Err(Error::ENOMEM);
+        }
+        // INVARIANTS: We checked that the allocation above succeeded>
+        Ok(Self { pages })
+    }
+
+    /// Maps a single page at the given address in the given VM area.
+    ///
+    /// This is only meant to be used by pages of order 0.
+    pub fn insert_page(&self, vma: &mut bindings::vm_area_struct, address: usize) -> Result {
+        if ORDER != 0 {
+            return Err(Error::EINVAL);
+        }
+
+        // SAFETY: We check above that the allocation is of order 0. The range of `address` is
+        // already checked by `vm_insert_page`.
+        let ret = unsafe { bindings::vm_insert_page(vma, address as _, self.pages) };
+        if ret != 0 {
+            Err(Error::from_kernel_errno(ret))
+        } else {
+            Ok(())
+        }
+    }
+
+    /// Copies data from the given [`UserSlicePtrReader`] into the pages.
+    pub fn copy_into_page(
+        &self,
+        reader: &mut UserSlicePtrReader,
+        offset: usize,
+        len: usize,
+    ) -> Result {
+        // TODO: For now this only works on the first page.
+        let end = offset.checked_add(len).ok_or(Error::EINVAL)?;
+        if end > PAGE_SIZE {
+            return Err(Error::EINVAL);
+        }
+
+        let mapping = self.kmap(0).ok_or(Error::EINVAL)?;
+
+        // SAFETY: We ensured that the buffer was valid with the check above.
+        unsafe { reader.read_raw((mapping.ptr as usize + offset) as _, len) }?;
+        Ok(())
+    }
+
+    /// Maps the pages and reads from them into the given buffer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the destination buffer is valid for the given length.
+    /// Additionally, if the raw buffer is intended to be recast, they must ensure that the data
+    /// can be safely cast; [`crate::io_buffer::ReadableFromBytes`] has more details about it.
+    pub unsafe fn read(&self, dest: *mut u8, offset: usize, len: usize) -> Result {
+        // TODO: For now this only works on the first page.
+        let end = offset.checked_add(len).ok_or(Error::EINVAL)?;
+        if end > PAGE_SIZE {
+            return Err(Error::EINVAL);
+        }
+
+        let mapping = self.kmap(0).ok_or(Error::EINVAL)?;
+        unsafe { ptr::copy((mapping.ptr as *mut u8).add(offset), dest, len) };
+        Ok(())
+    }
+
+    /// Maps the pages and writes into them from the given bufer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the buffer is valid for the given length. Additionally, if the
+    /// page is (or will be) mapped by userspace, they must ensure that no kernel data is leaked
+    /// through padding if it was cast from another type; [`crate::io_buffer::WritableToBytes`] has
+    /// more details about it.
+    pub unsafe fn write(&self, src: *const u8, offset: usize, len: usize) -> Result {
+        // TODO: For now this only works on the first page.
+        let end = offset.checked_add(len).ok_or(Error::EINVAL)?;
+        if end > PAGE_SIZE {
+            return Err(Error::EINVAL);
+        }
+
+        let mapping = self.kmap(0).ok_or(Error::EINVAL)?;
+        unsafe { ptr::copy(src, (mapping.ptr as *mut u8).add(offset), len) };
+        Ok(())
+    }
+
+    /// Maps the page at index `index`.
+    fn kmap(&self, index: usize) -> Option<PageMapping<'_>> {
+        if index >= 1usize << ORDER {
+            return None;
+        }
+
+        // SAFETY: We checked above that `index` is within range.
+        let page = unsafe { self.pages.add(index) };
+
+        // SAFETY: `page` is valid based on the checks above.
+        let ptr = unsafe { rust_helper_kmap(page) };
+        if ptr.is_null() {
+            return None;
+        }
+
+        Some(PageMapping {
+            page,
+            ptr,
+            _phantom: PhantomData,
+        })
+    }
+}
+
+impl<const ORDER: u32> Drop for Pages<ORDER> {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we know the pages are allocated with the given order.
+        unsafe { bindings::__free_pages(self.pages, ORDER) };
+    }
+}
+
+struct PageMapping<'a> {
+    page: *mut bindings::page,
+    ptr: *mut c_types::c_void,
+    _phantom: PhantomData<&'a i32>,
+}
+
+impl Drop for PageMapping<'_> {
+    fn drop(&mut self) {
+        // SAFETY: An instance of `PageMapping` is created only when `kmap` succeeded for the given
+        // page, so it is safe to unmap it here.
+        unsafe { rust_helper_kunmap(self.page) };
+    }
+}
diff --git a/rust/kernel/platdev.rs b/rust/kernel/platdev.rs
new file mode 100644
index 00000000000..5f306b61321
--- /dev/null
+++ b/rust/kernel/platdev.rs
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Platform devices.
+//!
+//! Also called `platdev`, `pdev`.
+//!
+//! C header: [`include/linux/platform_device.h`](../../../../include/linux/platform_device.h)
+
+use crate::{
+    bindings, c_types,
+    error::{Error, Result},
+    from_kernel_result,
+    of::OfMatchTable,
+    str::CStr,
+    types::PointerWrapper,
+};
+use alloc::boxed::Box;
+use core::{marker::PhantomPinned, pin::Pin};
+
+/// A registration of a platform device.
+#[derive(Default)]
+pub struct Registration {
+    registered: bool,
+    pdrv: bindings::platform_driver,
+    _pin: PhantomPinned,
+}
+
+// SAFETY: `Registration` does not expose any of its state across threads
+// (it is fine for multiple threads to have a shared reference to it).
+unsafe impl Sync for Registration {}
+
+extern "C" {
+    #[allow(improper_ctypes)]
+    fn rust_helper_platform_get_drvdata(
+        pdev: *const bindings::platform_device,
+    ) -> *mut c_types::c_void;
+
+    #[allow(improper_ctypes)]
+    fn rust_helper_platform_set_drvdata(
+        pdev: *mut bindings::platform_device,
+        data: *mut c_types::c_void,
+    );
+}
+
+extern "C" fn probe_callback<P: PlatformDriver>(
+    pdev: *mut bindings::platform_device,
+) -> c_types::c_int {
+    from_kernel_result! {
+        // SAFETY: `pdev` is guaranteed to be a valid, non-null pointer.
+        let device_id = unsafe { (*pdev).id };
+        let drv_data = P::probe(device_id)?;
+        let drv_data = drv_data.into_pointer() as *mut c_types::c_void;
+        // SAFETY: `pdev` is guaranteed to be a valid, non-null pointer.
+        unsafe {
+            rust_helper_platform_set_drvdata(pdev, drv_data);
+        }
+        Ok(0)
+    }
+}
+
+extern "C" fn remove_callback<P: PlatformDriver>(
+    pdev: *mut bindings::platform_device,
+) -> c_types::c_int {
+    from_kernel_result! {
+        // SAFETY: `pdev` is guaranteed to be a valid, non-null pointer.
+        let device_id = unsafe { (*pdev).id };
+        // SAFETY: `pdev` is guaranteed to be a valid, non-null pointer.
+        let ptr = unsafe { rust_helper_platform_get_drvdata(pdev) };
+        // SAFETY:
+        //   - we allocated this pointer using `P::DrvData::into_pointer`,
+        //     so it is safe to turn back into a `P::DrvData`.
+        //   - the allocation happened in `probe`, no-one freed the memory,
+        //     `remove` is the canonical kernel location to free driver data. so OK
+        //     to convert the pointer back to a Rust structure here.
+        let drv_data = unsafe { P::DrvData::from_pointer(ptr) };
+        P::remove(device_id, drv_data)?;
+        Ok(0)
+    }
+}
+
+impl Registration {
+    fn register<P: PlatformDriver>(
+        self: Pin<&mut Self>,
+        name: &'static CStr,
+        of_match_table: Option<&'static OfMatchTable>,
+        module: &'static crate::ThisModule,
+    ) -> Result {
+        // SAFETY: We must ensure that we never move out of `this`.
+        let this = unsafe { self.get_unchecked_mut() };
+        if this.registered {
+            // Already registered.
+            return Err(Error::EINVAL);
+        }
+        this.pdrv.driver.name = name.as_char_ptr();
+        if let Some(tbl) = of_match_table {
+            this.pdrv.driver.of_match_table = tbl.as_ptr();
+        }
+        this.pdrv.probe = Some(probe_callback::<P>);
+        this.pdrv.remove = Some(remove_callback::<P>);
+        // SAFETY:
+        //   - `this.pdrv` lives at least until the call to `platform_driver_unregister()` returns.
+        //   - `name` pointer has static lifetime.
+        //   - `module.0` lives at least as long as the module.
+        //   - `probe()` and `remove()` are static functions.
+        //   - `of_match_table` is either a raw pointer with static lifetime,
+        //      as guaranteed by the [`of::OfMatchTable::as_ptr()`] return type,
+        //      or null.
+        let ret = unsafe { bindings::__platform_driver_register(&mut this.pdrv, module.0) };
+        if ret < 0 {
+            return Err(Error::from_kernel_errno(ret));
+        }
+        this.registered = true;
+        Ok(())
+    }
+
+    /// Registers a platform device.
+    ///
+    /// Returns a pinned heap-allocated representation of the registration.
+    pub fn new_pinned<P: PlatformDriver>(
+        name: &'static CStr,
+        of_match_tbl: Option<&'static OfMatchTable>,
+        module: &'static crate::ThisModule,
+    ) -> Result<Pin<Box<Self>>> {
+        let mut r = Pin::from(Box::try_new(Self::default())?);
+        r.as_mut().register::<P>(name, of_match_tbl, module)?;
+        Ok(r)
+    }
+}
+
+impl Drop for Registration {
+    fn drop(&mut self) {
+        if self.registered {
+            // SAFETY: if `registered` is true, then `self.pdev` was registered
+            // previously, which means `platform_driver_unregister` is always
+            // safe to call.
+            unsafe { bindings::platform_driver_unregister(&mut self.pdrv) }
+        }
+    }
+}
+
+/// Trait for implementers of platform drivers.
+///
+/// Implement this trait whenever you create a platform driver.
+pub trait PlatformDriver {
+    /// Device driver data.
+    ///
+    /// Corresponds to the data set or retrieved via the kernel's
+    /// `platform_{set,get}_drvdata()` functions.
+    ///
+    /// Require that `DrvData` implements `PointerWrapper`. We guarantee to
+    /// never move the underlying wrapped data structure. This allows
+    /// driver writers to use pinned or self-referential data structures.
+    type DrvData: PointerWrapper;
+
+    /// Platform driver probe.
+    ///
+    /// Called when a new platform device is added or discovered.
+    /// Implementers should attempt to initialize the device here.
+    fn probe(device_id: i32) -> Result<Self::DrvData>;
+
+    /// Platform driver remove.
+    ///
+    /// Called when a platform device is removed.
+    /// Implementers should prepare the device for complete removal here.
+    fn remove(device_id: i32, drv_data: Self::DrvData) -> Result;
+}
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
new file mode 100644
index 00000000000..c0bf618099a
--- /dev/null
+++ b/rust/kernel/prelude.rs
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! The `kernel` prelude.
+//!
+//! These are the most common items used by Rust code in the kernel,
+//! intended to be imported by all Rust code, for convenience.
+//!
+//! # Examples
+//!
+//! ```
+//! use kernel::prelude::*;
+//! ```
+
+pub use core::pin::Pin;
+
+pub use alloc::{boxed::Box, string::String, sync::Arc, vec::Vec};
+
+pub use macros::{module, module_misc_device};
+
+pub use super::build_assert;
+
+pub use super::{pr_alert, pr_crit, pr_emerg, pr_err, pr_info, pr_notice, pr_warn};
+
+pub use super::static_assert;
+
+pub use super::{Error, KernelModule, Result};
+
+pub use crate::traits::TryPin;
diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
new file mode 100644
index 00000000000..b7384f0bacc
--- /dev/null
+++ b/rust/kernel/print.rs
@@ -0,0 +1,412 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Printing facilities.
+//!
+//! C header: [`include/linux/printk.h`](../../../../include/linux/printk.h)
+//!
+//! Reference: <https://www.kernel.org/doc/html/latest/core-api/printk-basics.html>
+
+use core::cmp;
+use core::fmt;
+
+use crate::bindings;
+use crate::c_types::{c_char, c_void};
+
+// Called from `vsprintf` with format specifier `%pA`.
+#[no_mangle]
+unsafe fn rust_fmt_argument(buf: *mut c_char, end: *mut c_char, ptr: *const c_void) -> *mut c_char {
+    use fmt::Write;
+
+    // Use `usize` to use `saturating_*` functions.
+    struct Writer {
+        buf: usize,
+        end: usize,
+    }
+
+    impl Write for Writer {
+        fn write_str(&mut self, s: &str) -> fmt::Result {
+            // `buf` value after writing `len` bytes. This does not have to be bounded
+            // by `end`, but we don't want it to wrap around to 0.
+            let buf_new = self.buf.saturating_add(s.len());
+
+            // Amount that we can copy. `saturating_sub` ensures we get 0 if
+            // `buf` goes past `end`.
+            let len_to_copy = cmp::min(buf_new, self.end).saturating_sub(self.buf);
+
+            // SAFETY: In any case, `buf` is non-null and properly aligned.
+            // If `len_to_copy` is non-zero, then we know `buf` has not past
+            // `end` yet and so is valid.
+            unsafe {
+                core::ptr::copy_nonoverlapping(
+                    s.as_bytes().as_ptr(),
+                    self.buf as *mut u8,
+                    len_to_copy,
+                )
+            };
+
+            self.buf = buf_new;
+            Ok(())
+        }
+    }
+
+    let mut w = Writer {
+        buf: buf as _,
+        end: end as _,
+    };
+    let _ = w.write_fmt(unsafe { *(ptr as *const fmt::Arguments<'_>) });
+    w.buf as _
+}
+
+/// Format strings.
+///
+/// Public but hidden since it should only be used from public macros.
+#[doc(hidden)]
+pub mod format_strings {
+    use crate::bindings;
+
+    /// The length we copy from the `KERN_*` kernel prefixes.
+    const LENGTH_PREFIX: usize = 2;
+
+    /// The length of the fixed format strings.
+    pub const LENGTH: usize = 10;
+
+    /// Generates a fixed format string for the kernel's [`printk`].
+    ///
+    /// The format string is always the same for a given level, i.e. for a
+    /// given `prefix`, which are the kernel's `KERN_*` constants.
+    ///
+    /// [`printk`]: ../../../../include/linux/printk.h
+    const fn generate(is_cont: bool, prefix: &[u8; 3]) -> [u8; LENGTH] {
+        // Ensure the `KERN_*` macros are what we expect.
+        assert!(prefix[0] == b'\x01');
+        if is_cont {
+            assert!(prefix[1] == b'c');
+        } else {
+            assert!(prefix[1] >= b'0' && prefix[1] <= b'7');
+        }
+        assert!(prefix[2] == b'\x00');
+
+        let suffix: &[u8; LENGTH - LENGTH_PREFIX] = if is_cont {
+            b"%pA\0\0\0\0\0"
+        } else {
+            b"%s: %pA\0"
+        };
+
+        [
+            prefix[0], prefix[1], suffix[0], suffix[1], suffix[2], suffix[3], suffix[4], suffix[5],
+            suffix[6], suffix[7],
+        ]
+    }
+
+    // Generate the format strings at compile-time.
+    //
+    // This avoids the compiler generating the contents on the fly in the stack.
+    //
+    // Furthermore, `static` instead of `const` is used to share the strings
+    // for all the kernel.
+    pub static EMERG: [u8; LENGTH] = generate(false, bindings::KERN_EMERG);
+    pub static ALERT: [u8; LENGTH] = generate(false, bindings::KERN_ALERT);
+    pub static CRIT: [u8; LENGTH] = generate(false, bindings::KERN_CRIT);
+    pub static ERR: [u8; LENGTH] = generate(false, bindings::KERN_ERR);
+    pub static WARNING: [u8; LENGTH] = generate(false, bindings::KERN_WARNING);
+    pub static NOTICE: [u8; LENGTH] = generate(false, bindings::KERN_NOTICE);
+    pub static INFO: [u8; LENGTH] = generate(false, bindings::KERN_INFO);
+    pub static DEBUG: [u8; LENGTH] = generate(false, bindings::KERN_DEBUG);
+    pub static CONT: [u8; LENGTH] = generate(true, bindings::KERN_CONT);
+}
+
+/// Prints a message via the kernel's [`printk`].
+///
+/// Public but hidden since it should only be used from public macros.
+///
+/// # Safety
+///
+/// The format string must be one of the ones in [`format_strings`], and
+/// the module name must be null-terminated.
+///
+/// [`printk`]: ../../../../include/linux/printk.h
+#[doc(hidden)]
+pub unsafe fn call_printk(
+    format_string: &[u8; format_strings::LENGTH],
+    module_name: &[u8],
+    args: fmt::Arguments<'_>,
+) {
+    // `printk` does not seem to fail in any path.
+    unsafe {
+        bindings::printk(
+            format_string.as_ptr() as _,
+            module_name.as_ptr(),
+            &args as *const _ as *const c_void,
+        );
+    }
+}
+
+/// Prints a message via the kernel's [`printk`] for the `CONT` level.
+///
+/// Public but hidden since it should only be used from public macros.
+///
+/// [`printk`]: ../../../../include/linux/printk.h
+#[doc(hidden)]
+pub fn call_printk_cont(args: fmt::Arguments<'_>) {
+    // `printk` does not seem to fail in any path.
+    //
+    // SAFETY: The format string is fixed.
+    unsafe {
+        bindings::printk(
+            format_strings::CONT.as_ptr() as _,
+            &args as *const _ as *const c_void,
+        );
+    }
+}
+
+/// Performs formatting and forwards the string to [`call_printk`].
+///
+/// Public but hidden since it should only be used from public macros.
+#[doc(hidden)]
+#[cfg(not(testlib))]
+#[macro_export]
+macro_rules! print_macro (
+    // The non-continuation cases (most of them, e.g. `INFO`).
+    ($format_string:path, false, $($arg:tt)+) => (
+        // SAFETY: This hidden macro should only be called by the documented
+        // printing macros which ensure the format string is one of the fixed
+        // ones. All `__LOG_PREFIX`s are null-terminated as they are generated
+        // by the `module!` proc macro or fixed values defined in a kernel
+        // crate.
+        unsafe {
+            $crate::print::call_printk(
+                &$format_string,
+                crate::__LOG_PREFIX,
+                format_args!($($arg)+),
+            );
+        }
+    );
+
+    // The `CONT` case.
+    ($format_string:path, true, $($arg:tt)+) => (
+        $crate::print::call_printk_cont(
+            format_args!($($arg)+),
+        );
+    );
+);
+
+/// Stub for doctests
+#[cfg(testlib)]
+#[macro_export]
+macro_rules! print_macro (
+    ($format_string:path, $e:expr, $($arg:tt)+) => (
+        ()
+    );
+);
+
+// We could use a macro to generate these macros. However, doing so ends
+// up being a bit ugly: it requires the dollar token trick to escape `$` as
+// well as playing with the `doc` attribute. Furthermore, they cannot be easily
+// imported in the prelude due to [1]. So, for the moment, we just write them
+// manually, like in the C side; while keeping most of the logic in another
+// macro, i.e. [`print_macro`].
+//
+// [1]: https://github.com/rust-lang/rust/issues/52234
+
+/// Prints an emergency-level message (level 0).
+///
+/// Use this level if the system is unusable.
+///
+/// Equivalent to the kernel's [`pr_emerg`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// [`alloc::format!`] for information about the formatting syntax.
+///
+/// [`pr_emerg`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_emerg
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// pr_emerg!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_emerg (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::EMERG, false, $($arg)*)
+    )
+);
+
+/// Prints an alert-level message (level 1).
+///
+/// Use this level if action must be taken immediately.
+///
+/// Equivalent to the kernel's [`pr_alert`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// [`alloc::format!`] for information about the formatting syntax.
+///
+/// [`pr_alert`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_alert
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// pr_alert!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_alert (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::ALERT, false, $($arg)*)
+    )
+);
+
+/// Prints a critical-level message (level 2).
+///
+/// Use this level for critical conditions.
+///
+/// Equivalent to the kernel's [`pr_crit`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// [`alloc::format!`] for information about the formatting syntax.
+///
+/// [`pr_crit`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_crit
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// pr_crit!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_crit (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::CRIT, false, $($arg)*)
+    )
+);
+
+/// Prints an error-level message (level 3).
+///
+/// Use this level for error conditions.
+///
+/// Equivalent to the kernel's [`pr_err`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// [`alloc::format!`] for information about the formatting syntax.
+///
+/// [`pr_err`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_err
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// pr_err!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_err (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::ERR, false, $($arg)*)
+    )
+);
+
+/// Prints a warning-level message (level 4).
+///
+/// Use this level for warning conditions.
+///
+/// Equivalent to the kernel's [`pr_warn`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// [`alloc::format!`] for information about the formatting syntax.
+///
+/// [`pr_warn`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_warn
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// pr_warn!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_warn (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::WARNING, false, $($arg)*)
+    )
+);
+
+/// Prints a notice-level message (level 5).
+///
+/// Use this level for normal but significant conditions.
+///
+/// Equivalent to the kernel's [`pr_notice`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// [`alloc::format!`] for information about the formatting syntax.
+///
+/// [`pr_notice`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_notice
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// pr_notice!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_notice (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::NOTICE, false, $($arg)*)
+    )
+);
+
+/// Prints an info-level message (level 6).
+///
+/// Use this level for informational messages.
+///
+/// Equivalent to the kernel's [`pr_info`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// [`alloc::format!`] for information about the formatting syntax.
+///
+/// [`pr_info`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_info
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// pr_info!("hello {}\n", "there");
+/// ```
+#[macro_export]
+#[doc(alias = "print")]
+macro_rules! pr_info (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::INFO, false, $($arg)*)
+    )
+);
+
+/// Continues a previous log message in the same line.
+///
+/// Use only when continuing a previous `pr_*!` macro (e.g. [`pr_info!`]).
+///
+/// Equivalent to the kernel's [`pr_cont`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// [`alloc::format!`] for information about the formatting syntax.
+///
+/// [`pr_cont`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_cont
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::pr_cont;
+/// pr_info!("hello");
+/// pr_cont!(" {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_cont (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::CONT, true, $($arg)*)
+    )
+);
diff --git a/rust/kernel/random.rs b/rust/kernel/random.rs
new file mode 100644
index 00000000000..723a89829f6
--- /dev/null
+++ b/rust/kernel/random.rs
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Random numbers.
+//!
+//! C header: [`include/linux/random.h`](../../../../include/linux/random.h)
+
+use core::convert::TryInto;
+
+use crate::{bindings, c_types, error};
+
+/// Fills a byte slice with random bytes generated from the kernel's CSPRNG.
+///
+/// Ensures that the CSPRNG has been seeded before generating any random bytes,
+/// and will block until it is ready.
+pub fn getrandom(dest: &mut [u8]) -> error::Result {
+    let res = unsafe { bindings::wait_for_random_bytes() };
+    if res != 0 {
+        return Err(error::Error::from_kernel_errno(res));
+    }
+
+    unsafe {
+        bindings::get_random_bytes(
+            dest.as_mut_ptr() as *mut c_types::c_void,
+            dest.len().try_into()?,
+        );
+    }
+    Ok(())
+}
+
+/// Fills a byte slice with random bytes generated from the kernel's CSPRNG.
+///
+/// If the CSPRNG is not yet seeded, returns an `Err(EAGAIN)` immediately.
+pub fn getrandom_nonblock(dest: &mut [u8]) -> error::Result {
+    if !unsafe { bindings::rng_is_initialized() } {
+        return Err(error::Error::EAGAIN);
+    }
+    getrandom(dest)
+}
+
+/// Contributes the contents of a byte slice to the kernel's entropy pool.
+///
+/// Does *not* credit the kernel entropy counter though.
+pub fn add_randomness(data: &[u8]) {
+    unsafe {
+        bindings::add_device_randomness(
+            data.as_ptr() as *const c_types::c_void,
+            data.len().try_into().unwrap(),
+        );
+    }
+}
diff --git a/rust/kernel/raw_list.rs b/rust/kernel/raw_list.rs
new file mode 100644
index 00000000000..4bc4f4a24ad
--- /dev/null
+++ b/rust/kernel/raw_list.rs
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Raw lists.
+//!
+//! TODO: This module is a work in progress.
+
+use core::{
+    cell::UnsafeCell,
+    ptr,
+    ptr::NonNull,
+    sync::atomic::{AtomicBool, Ordering},
+};
+
+/// A descriptor of list elements.
+///
+/// It describes the type of list elements and provides a function to determine how to get the
+/// links to be used on a list.
+///
+/// A type that may be in multiple lists simultaneously neneds to implement one of these for each
+/// simultaneous list.
+pub trait GetLinks {
+    /// The type of the entries in the list.
+    type EntryType: ?Sized;
+
+    /// Returns the links to be used when linking an entry within a list.
+    fn get_links(data: &Self::EntryType) -> &Links<Self::EntryType>;
+}
+
+/// The links used to link an object on a linked list.
+///
+/// Instances of this type are usually embedded in structures and returned in calls to
+/// [`GetLinks::get_links`].
+pub struct Links<T: ?Sized> {
+    inserted: AtomicBool,
+    entry: UnsafeCell<ListEntry<T>>,
+}
+
+impl<T: ?Sized> Links<T> {
+    /// Constructs a new [`Links`] instance that isn't inserted on any lists yet.
+    pub fn new() -> Self {
+        Self {
+            inserted: AtomicBool::new(false),
+            entry: UnsafeCell::new(ListEntry::new()),
+        }
+    }
+
+    fn acquire_for_insertion(&self) -> bool {
+        self.inserted
+            .compare_exchange(false, true, Ordering::Acquire, Ordering::Relaxed)
+            .is_ok()
+    }
+
+    fn release_after_removal(&self) {
+        self.inserted.store(false, Ordering::Release);
+    }
+}
+
+impl<T: ?Sized> Default for Links<T> {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+struct ListEntry<T: ?Sized> {
+    next: Option<NonNull<T>>,
+    prev: Option<NonNull<T>>,
+}
+
+impl<T: ?Sized> ListEntry<T> {
+    fn new() -> Self {
+        Self {
+            next: None,
+            prev: None,
+        }
+    }
+}
+
+/// A linked list.
+///
+/// # Invariants
+///
+/// The links of objects added to a list are owned by the list.
+pub(crate) struct RawList<G: GetLinks> {
+    head: Option<NonNull<G::EntryType>>,
+}
+
+impl<G: GetLinks> RawList<G> {
+    pub(crate) fn new() -> Self {
+        Self { head: None }
+    }
+
+    pub(crate) fn is_empty(&self) -> bool {
+        self.head.is_none()
+    }
+
+    fn insert_after_priv(
+        &mut self,
+        existing: &G::EntryType,
+        new_entry: &mut ListEntry<G::EntryType>,
+        new_ptr: Option<NonNull<G::EntryType>>,
+    ) {
+        {
+            // SAFETY: It's safe to get the previous entry of `existing` because the list cannot
+            // change.
+            let existing_links = unsafe { &mut *G::get_links(existing).entry.get() };
+            new_entry.next = existing_links.next;
+            existing_links.next = new_ptr;
+        }
+
+        new_entry.prev = Some(NonNull::from(existing));
+
+        // SAFETY: It's safe to get the next entry of `existing` because the list cannot change.
+        let next_links =
+            unsafe { &mut *G::get_links(new_entry.next.unwrap().as_ref()).entry.get() };
+        next_links.prev = new_ptr;
+    }
+
+    /// Inserts the given object after `existing`.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `existing` points to a valid entry that is on the list.
+    pub(crate) unsafe fn insert_after(
+        &mut self,
+        existing: &G::EntryType,
+        new: &G::EntryType,
+    ) -> bool {
+        let links = G::get_links(new);
+        if !links.acquire_for_insertion() {
+            // Nothing to do if already inserted.
+            return false;
+        }
+
+        // SAFETY: The links are now owned by the list, so it is safe to get a mutable reference.
+        let new_entry = unsafe { &mut *links.entry.get() };
+        self.insert_after_priv(existing, new_entry, Some(NonNull::from(new)));
+        true
+    }
+
+    fn push_back_internal(&mut self, new: &G::EntryType) -> bool {
+        let links = G::get_links(new);
+        if !links.acquire_for_insertion() {
+            // Nothing to do if already inserted.
+            return false;
+        }
+
+        // SAFETY: The links are now owned by the list, so it is safe to get a mutable reference.
+        let new_entry = unsafe { &mut *links.entry.get() };
+        let new_ptr = Some(NonNull::from(new));
+        match self.back() {
+            // SAFETY: `back` is valid as the list cannot change.
+            Some(back) => self.insert_after_priv(unsafe { back.as_ref() }, new_entry, new_ptr),
+            None => {
+                self.head = new_ptr;
+                new_entry.next = new_ptr;
+                new_entry.prev = new_ptr;
+            }
+        }
+        true
+    }
+
+    pub(crate) unsafe fn push_back(&mut self, new: &G::EntryType) -> bool {
+        self.push_back_internal(new)
+    }
+
+    fn remove_internal(&mut self, data: &G::EntryType) -> bool {
+        let links = G::get_links(data);
+
+        // SAFETY: The links are now owned by the list, so it is safe to get a mutable reference.
+        let entry = unsafe { &mut *links.entry.get() };
+        let next = if let Some(next) = entry.next {
+            next
+        } else {
+            // Nothing to do if the entry is not on the list.
+            return false;
+        };
+
+        if ptr::eq(data, next.as_ptr()) {
+            // We're removing the only element.
+            self.head = None
+        } else {
+            // Update the head if we're removing it.
+            if let Some(raw_head) = self.head {
+                if ptr::eq(data, raw_head.as_ptr()) {
+                    self.head = Some(next);
+                }
+            }
+
+            // SAFETY: It's safe to get the previous entry because the list cannot change.
+            unsafe { &mut *G::get_links(entry.prev.unwrap().as_ref()).entry.get() }.next =
+                entry.next;
+
+            // SAFETY: It's safe to get the next entry because the list cannot change.
+            unsafe { &mut *G::get_links(next.as_ref()).entry.get() }.prev = entry.prev;
+        }
+
+        // Reset the links of the element we're removing so that we know it's not on any list.
+        entry.next = None;
+        entry.prev = None;
+        links.release_after_removal();
+        true
+    }
+
+    /// Removes the given entry.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `data` is either on this list or in no list. It being on another
+    /// list leads to memory unsafety.
+    pub(crate) unsafe fn remove(&mut self, data: &G::EntryType) -> bool {
+        self.remove_internal(data)
+    }
+
+    fn pop_front_internal(&mut self) -> Option<NonNull<G::EntryType>> {
+        let head = self.head?;
+        // SAFETY: The head is on the list as we just got it from there and it cannot change.
+        unsafe { self.remove(head.as_ref()) };
+        Some(head)
+    }
+
+    pub(crate) fn pop_front(&mut self) -> Option<NonNull<G::EntryType>> {
+        self.pop_front_internal()
+    }
+
+    pub(crate) fn front(&self) -> Option<NonNull<G::EntryType>> {
+        self.head
+    }
+
+    pub(crate) fn back(&self) -> Option<NonNull<G::EntryType>> {
+        // SAFETY: The links of head are owned by the list, so it is safe to get a reference.
+        unsafe { &*G::get_links(self.head?.as_ref()).entry.get() }.prev
+    }
+
+    pub(crate) fn cursor_front(&self) -> Cursor<'_, G> {
+        Cursor::new(self, self.front())
+    }
+
+    pub(crate) fn cursor_front_mut(&mut self) -> CursorMut<'_, G> {
+        CursorMut::new(self, self.front())
+    }
+}
+
+struct CommonCursor<G: GetLinks> {
+    cur: Option<NonNull<G::EntryType>>,
+}
+
+impl<G: GetLinks> CommonCursor<G> {
+    fn new(cur: Option<NonNull<G::EntryType>>) -> Self {
+        Self { cur }
+    }
+
+    fn move_next(&mut self, list: &RawList<G>) {
+        match self.cur.take() {
+            None => self.cur = list.head,
+            Some(cur) => {
+                if let Some(head) = list.head {
+                    // SAFETY: We have a shared ref to the linked list, so the links can't change.
+                    let links = unsafe { &*G::get_links(cur.as_ref()).entry.get() };
+                    if links.next.unwrap() != head {
+                        self.cur = links.next;
+                    }
+                }
+            }
+        }
+    }
+
+    fn move_prev(&mut self, list: &RawList<G>) {
+        match list.head {
+            None => self.cur = None,
+            Some(head) => {
+                let next = match self.cur.take() {
+                    None => head,
+                    Some(cur) => {
+                        if cur == head {
+                            return;
+                        }
+                        cur
+                    }
+                };
+                // SAFETY: There's a shared ref to the list, so the links can't change.
+                let links = unsafe { &*G::get_links(next.as_ref()).entry.get() };
+                self.cur = links.prev;
+            }
+        }
+    }
+}
+
+/// A list cursor that allows traversing a linked list and inspecting elements.
+pub struct Cursor<'a, G: GetLinks> {
+    cursor: CommonCursor<G>,
+    list: &'a RawList<G>,
+}
+
+impl<'a, G: GetLinks> Cursor<'a, G> {
+    fn new(list: &'a RawList<G>, cur: Option<NonNull<G::EntryType>>) -> Self {
+        Self {
+            list,
+            cursor: CommonCursor::new(cur),
+        }
+    }
+
+    /// Returns the element the cursor is currently positioned on.
+    pub fn current(&self) -> Option<&'a G::EntryType> {
+        let cur = self.cursor.cur?;
+        // SAFETY: Objects must be kept alive while on the list.
+        Some(unsafe { &*cur.as_ptr() })
+    }
+
+    /// Moves the cursor to the next element.
+    pub fn move_next(&mut self) {
+        self.cursor.move_next(self.list);
+    }
+}
+
+pub(crate) struct CursorMut<'a, G: GetLinks> {
+    cursor: CommonCursor<G>,
+    list: &'a mut RawList<G>,
+}
+
+impl<'a, G: GetLinks> CursorMut<'a, G> {
+    fn new(list: &'a mut RawList<G>, cur: Option<NonNull<G::EntryType>>) -> Self {
+        Self {
+            list,
+            cursor: CommonCursor::new(cur),
+        }
+    }
+
+    pub(crate) fn current(&mut self) -> Option<&mut G::EntryType> {
+        let cur = self.cursor.cur?;
+        // SAFETY: Objects must be kept alive while on the list.
+        Some(unsafe { &mut *cur.as_ptr() })
+    }
+
+    /// Removes the entry the cursor is pointing to and advances the cursor to the next entry. It
+    /// returns a raw pointer to the removed element (if one is removed).
+    pub(crate) fn remove_current(&mut self) -> Option<NonNull<G::EntryType>> {
+        let entry = self.cursor.cur?;
+        self.cursor.move_next(self.list);
+        // SAFETY: The entry is on the list as we just got it from there and it cannot change.
+        unsafe { self.list.remove(entry.as_ref()) };
+        Some(entry)
+    }
+
+    pub(crate) fn peek_next(&mut self) -> Option<&mut G::EntryType> {
+        let mut new = CommonCursor::new(self.cursor.cur);
+        new.move_next(self.list);
+        // SAFETY: Objects must be kept alive while on the list.
+        Some(unsafe { &mut *new.cur?.as_ptr() })
+    }
+
+    pub(crate) fn peek_prev(&mut self) -> Option<&mut G::EntryType> {
+        let mut new = CommonCursor::new(self.cursor.cur);
+        new.move_prev(self.list);
+        // SAFETY: Objects must be kept alive while on the list.
+        Some(unsafe { &mut *new.cur?.as_ptr() })
+    }
+
+    pub(crate) fn move_next(&mut self) {
+        self.cursor.move_next(self.list);
+    }
+}
diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
new file mode 100644
index 00000000000..63086536950
--- /dev/null
+++ b/rust/kernel/rbtree.rs
@@ -0,0 +1,570 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Red-black trees.
+//!
+//! C header: [`include/linux/rbtree.h`](../../../../include/linux/rbtree.h)
+//!
+//! Reference: <https://www.kernel.org/doc/html/latest/core-api/rbtree.html>
+
+use crate::{bindings, Result};
+use alloc::boxed::Box;
+use core::{
+    cmp::{Ord, Ordering},
+    iter::{IntoIterator, Iterator},
+    marker::PhantomData,
+    mem::MaybeUninit,
+    ptr::{addr_of_mut, NonNull},
+};
+
+extern "C" {
+    fn rust_helper_rb_link_node(
+        node: *mut bindings::rb_node,
+        parent: *const bindings::rb_node,
+        rb_link: *mut *mut bindings::rb_node,
+    );
+}
+
+struct Node<K, V> {
+    links: bindings::rb_node,
+    key: K,
+    value: V,
+}
+
+/// A red-black tree with owned nodes.
+///
+/// It is backed by the kernel C red-black trees.
+///
+/// # Invariants
+///
+/// Non-null parent/children pointers stored in instances of the `rb_node` C struct are always
+/// valid, and pointing to a field of our internal representation of a node.
+///
+/// # Examples
+///
+/// In the example below we do several operations on a tree. We note that insertions may fail if
+/// the system is out of memory.
+///
+/// ```
+/// # use kernel::prelude::*;
+/// use kernel::rbtree::RBTree;
+///
+/// fn rbtest() -> Result {
+///     // Create a new tree.
+///     let mut tree = RBTree::new();
+///
+///     // Insert three elements.
+///     tree.try_insert(20, 200)?;
+///     tree.try_insert(10, 100)?;
+///     tree.try_insert(30, 300)?;
+///
+///     // Check the nodes we just inserted.
+///     {
+///         let mut iter = tree.iter();
+///         assert_eq!(iter.next().unwrap(), (&10, &100));
+///         assert_eq!(iter.next().unwrap(), (&20, &200));
+///         assert_eq!(iter.next().unwrap(), (&30, &300));
+///         assert!(iter.next().is_none());
+///     }
+///
+///     // Print all elements.
+///     for (key, value) in &tree {
+///         pr_info!("{} = {}\n", key, value);
+///     }
+///
+///     // Replace one of the elements.
+///     tree.try_insert(10, 1000)?;
+///
+///     // Check that the tree reflects the replacement.
+///     {
+///         let mut iter = tree.iter();
+///         assert_eq!(iter.next().unwrap(), (&10, &1000));
+///         assert_eq!(iter.next().unwrap(), (&20, &200));
+///         assert_eq!(iter.next().unwrap(), (&30, &300));
+///         assert!(iter.next().is_none());
+///     }
+///
+///     // Change the value of one of the elements.
+///     *tree.get_mut(&30).unwrap() = 3000;
+///
+///     // Check that the tree reflects the update.
+///     {
+///         let mut iter = tree.iter();
+///         assert_eq!(iter.next().unwrap(), (&10, &1000));
+///         assert_eq!(iter.next().unwrap(), (&20, &200));
+///         assert_eq!(iter.next().unwrap(), (&30, &3000));
+///         assert!(iter.next().is_none());
+///     }
+///
+///     // Remove an element.
+///     tree.remove(&10);
+///
+///     // Check that the tree reflects the removal.
+///     {
+///         let mut iter = tree.iter();
+///         assert_eq!(iter.next().unwrap(), (&20, &200));
+///         assert_eq!(iter.next().unwrap(), (&30, &3000));
+///         assert!(iter.next().is_none());
+///     }
+///
+///     // Update all values.
+///     for value in tree.values_mut() {
+///         *value *= 10;
+///     }
+///
+///     // Check that the tree reflects the changes to values.
+///     {
+///         let mut iter = tree.iter();
+///         assert_eq!(iter.next().unwrap(), (&20, &2000));
+///         assert_eq!(iter.next().unwrap(), (&30, &30000));
+///         assert!(iter.next().is_none());
+///     }
+///
+///     Ok(())
+/// }
+/// ```
+///
+/// In the example below, we first allocate a node, acquire a spinlock, then insert the node into
+/// the tree. This is useful when the insertion context does not allow sleeping, for example, when
+/// holding a spinlock.
+///
+/// ```
+/// # use kernel::prelude::*;
+/// use kernel::{rbtree::RBTree, sync::SpinLock};
+///
+/// fn insert_test(tree: &SpinLock<RBTree<u32, u32>>) -> Result {
+///     // Pre-allocate node. This may fail (as it allocates memory).
+///     let node = RBTree::try_allocate_node(10, 100)?;
+///
+///     // Insert node while holding the lock. It is guaranteed to succeed with no allocation
+///     // attempts.
+///     let mut guard = tree.lock();
+///     guard.insert(node);
+///     Ok(())
+/// }
+/// ```
+///
+/// In the example below, we reuse an existing node allocation from an element we removed.
+///
+/// ```
+/// # use kernel::prelude::*;
+/// use kernel::rbtree::RBTree;
+///
+/// fn reuse_test() -> Result {
+///     // Create a new tree.
+///     let mut tree = RBTree::new();
+///
+///     // Insert three elements.
+///     tree.try_insert(20, 200)?;
+///     tree.try_insert(10, 100)?;
+///     tree.try_insert(30, 300)?;
+///
+///     // Check the nodes we just inserted.
+///     {
+///         let mut iter = tree.iter();
+///         assert_eq!(iter.next().unwrap(), (&10, &100));
+///         assert_eq!(iter.next().unwrap(), (&20, &200));
+///         assert_eq!(iter.next().unwrap(), (&30, &300));
+///         assert!(iter.next().is_none());
+///     }
+///
+///     // Remove a node, getting back ownership of it.
+///     let existing = tree.remove_node(&30).unwrap();
+///
+///     // Check that the tree reflects the removal.
+///     {
+///         let mut iter = tree.iter();
+///         assert_eq!(iter.next().unwrap(), (&10, &100));
+///         assert_eq!(iter.next().unwrap(), (&20, &200));
+///         assert!(iter.next().is_none());
+///     }
+///
+///     // Turn the node into a reservation so that we can reuse it with a different key/value.
+///     let reservation = existing.into_reservation();
+///
+///     // Insert a new node into the tree, reusing the previous allocation. This is guaranteed to
+///     // succeed (no memory allocations).
+///     tree.insert(reservation.into_node(15, 150));
+///
+///     // Check that the tree reflect the new insertion.
+///     {
+///         let mut iter = tree.iter();
+///         assert_eq!(iter.next().unwrap(), (&10, &100));
+///         assert_eq!(iter.next().unwrap(), (&15, &150));
+///         assert_eq!(iter.next().unwrap(), (&20, &200));
+///         assert!(iter.next().is_none());
+///     }
+///
+///     Ok(())
+/// }
+/// ```
+pub struct RBTree<K, V> {
+    root: bindings::rb_root,
+    _p: PhantomData<Node<K, V>>,
+}
+
+impl<K, V> RBTree<K, V> {
+    /// Creates a new and empty tree.
+    pub fn new() -> Self {
+        Self {
+            // INVARIANT: There are no nodes in the tree, so the invariant holds vacuously.
+            root: bindings::rb_root::default(),
+            _p: PhantomData,
+        }
+    }
+
+    /// Tries to insert a new value into the tree.
+    ///
+    /// It overwrites a node if one already exists with the same key and returns it (containing the
+    /// key/value pair). Returns [`None`] if a node with the same key didn't already exist.
+    ///
+    /// Returns an error if it cannot allocate memory for the new node.
+    pub fn try_insert(&mut self, key: K, value: V) -> Result<Option<RBTreeNode<K, V>>>
+    where
+        K: Ord,
+    {
+        Ok(self.insert(Self::try_allocate_node(key, value)?))
+    }
+
+    /// Allocates memory for a node to be eventually initialised and inserted into the tree via a
+    /// call to [`RBTree::insert`].
+    pub fn try_reserve_node() -> Result<RBTreeNodeReservation<K, V>> {
+        Ok(RBTreeNodeReservation {
+            node: Box::try_new(MaybeUninit::uninit())?,
+        })
+    }
+
+    /// Allocates and initialiases a node that can be inserted into the tree via
+    /// [`RBTree::insert`].
+    pub fn try_allocate_node(key: K, value: V) -> Result<RBTreeNode<K, V>> {
+        Ok(Self::try_reserve_node()?.into_node(key, value))
+    }
+
+    /// Inserts a new node into the tree.
+    ///
+    /// It overwrites a node if one already exists with the same key and returns it (containing the
+    /// key/value pair). Returns [`None`] if a node with the same key didn't already exist.
+    ///
+    /// This function always succeeds.
+    pub fn insert(&mut self, node: RBTreeNode<K, V>) -> Option<RBTreeNode<K, V>>
+    where
+        K: Ord,
+    {
+        let RBTreeNode { node } = node;
+        let node = Box::into_raw(node);
+        // SAFETY: `node` is valid at least until we call `Box::from_raw`, which only happens when
+        // the node is removed or replaced.
+        let node_links = unsafe { addr_of_mut!((*node).links) };
+        let mut new_link: &mut *mut bindings::rb_node = &mut self.root.rb_node;
+        let mut parent = core::ptr::null_mut();
+        while !new_link.is_null() {
+            let this = crate::container_of!(*new_link, Node<K, V>, links);
+
+            parent = *new_link;
+
+            // SAFETY: `this` is a non-null node so it is valid by the type invariants. `node` is
+            // valid until the node is removed.
+            match unsafe { (*node).key.cmp(&(*this).key) } {
+                // SAFETY: `parent` is a non-null node so it is valid by the type invariants.
+                Ordering::Less => new_link = unsafe { &mut (*parent).rb_left },
+                // SAFETY: `parent` is a non-null node so it is valid by the type invariants.
+                Ordering::Greater => new_link = unsafe { &mut (*parent).rb_right },
+                Ordering::Equal => {
+                    // INVARIANT: We are replacing an existing node with a new one, which is valid.
+                    // It remains valid because we "forgot" it with `Box::into_raw`.
+                    // SAFETY: All pointers are non-null and valid (parent, despite the name, really
+                    // is the node we're replacing).
+                    unsafe { bindings::rb_replace_node(parent, node_links, &mut self.root) };
+
+                    // INVARIANT: The node is being returned and the caller may free it, however,
+                    // it was removed from the tree. So the invariants still hold.
+                    return Some(RBTreeNode {
+                        // SAFETY: `this` was a node in the tree, so it is valid.
+                        node: unsafe { Box::from_raw(this as _) },
+                    });
+                }
+            }
+        }
+
+        // INVARIANT: We are linking in a new node, which is valid. It remains valid because we
+        // "forgot" it with `Box::into_raw`.
+        // SAFETY: All pointers are non-null and valid (`*new_link` is null, but `new_link` is a
+        // mutable reference).
+        unsafe { rust_helper_rb_link_node(node_links, parent, new_link) };
+
+        // SAFETY: All pointers are valid. `node` has just been inserted into the tree.
+        unsafe { bindings::rb_insert_color(node_links, &mut self.root) };
+        None
+    }
+
+    /// Returns a node with the given key, if one exists.
+    fn find(&self, key: &K) -> Option<NonNull<Node<K, V>>>
+    where
+        K: Ord,
+    {
+        let mut node = self.root.rb_node;
+        while !node.is_null() {
+            let this = crate::container_of!(node, Node<K, V>, links);
+            // SAFETY: `this` is a non-null node so it is valid by the type invariants.
+            node = match key.cmp(unsafe { &(*this).key }) {
+                // SAFETY: `node` is a non-null node so it is valid by the type invariants.
+                Ordering::Less => unsafe { (*node).rb_left },
+                // SAFETY: `node` is a non-null node so it is valid by the type invariants.
+                Ordering::Greater => unsafe { (*node).rb_right },
+                Ordering::Equal => return NonNull::new(this as _),
+            }
+        }
+        None
+    }
+
+    /// Returns a reference to the value corresponding to the key.
+    pub fn get(&self, key: &K) -> Option<&V>
+    where
+        K: Ord,
+    {
+        // SAFETY: The `find` return value is a node in the tree, so it is valid.
+        self.find(key).map(|node| unsafe { &node.as_ref().value })
+    }
+
+    /// Returns a mutable reference to the value corresponding to the key.
+    pub fn get_mut(&mut self, key: &K) -> Option<&mut V>
+    where
+        K: Ord,
+    {
+        // SAFETY: the `find` return value is a node in the tree, so it is valid.
+        self.find(key)
+            .map(|mut node| unsafe { &mut node.as_mut().value })
+    }
+
+    /// Removes the node with the given key from the tree.
+    ///
+    /// It returns the node that was removed if one exists, or [`None`] otherwise.
+    pub fn remove_node(&mut self, key: &K) -> Option<RBTreeNode<K, V>>
+    where
+        K: Ord,
+    {
+        let mut node = self.find(key)?;
+
+        // SAFETY: the `find` return value is a node in the tree, so it is valid.
+        unsafe { bindings::rb_erase(&mut node.as_mut().links, &mut self.root) };
+
+        // INVARIANT: The node is being returned and the caller may free it, however, it was
+        // removed from the tree. So the invariants still hold.
+        Some(RBTreeNode {
+            // SAFETY: the `find` return value was a node in the tree, so it is valid.
+            node: unsafe { Box::from_raw(node.as_ptr()) },
+        })
+    }
+
+    /// Removes the node with the given key from the tree.
+    ///
+    /// It returns the value that was removed if one exists, or [`None`] otherwise.
+    pub fn remove(&mut self, key: &K) -> Option<V>
+    where
+        K: Ord,
+    {
+        let node = self.remove_node(key)?;
+        let RBTreeNode { node } = node;
+        let Node {
+            links: _,
+            key: _,
+            value,
+        } = *node;
+        Some(value)
+    }
+
+    /// Returns an iterator over the tree nodes, sorted by key.
+    pub fn iter(&self) -> RBTreeIterator<'_, K, V> {
+        RBTreeIterator {
+            _tree: PhantomData,
+            // SAFETY: `root` is valid as it's embedded in `self` and we have a valid `self`.
+            next: unsafe { bindings::rb_first(&self.root) },
+        }
+    }
+
+    /// Returns a mutable iterator over the tree nodes, sorted by key.
+    pub fn iter_mut(&mut self) -> RBTreeIteratorMut<'_, K, V> {
+        RBTreeIteratorMut {
+            _tree: PhantomData,
+            // SAFETY: `root` is valid as it's embedded in `self` and we have a valid `self`.
+            next: unsafe { bindings::rb_first(&self.root) },
+        }
+    }
+
+    /// Returns an iterator over the keys of the nodes in the tree, in sorted order.
+    pub fn keys(&self) -> impl Iterator<Item = &'_ K> {
+        self.iter().map(|(k, _)| k)
+    }
+
+    /// Returns an iterator over the values of the nodes in the tree, sorted by key.
+    pub fn values(&self) -> impl Iterator<Item = &'_ V> {
+        self.iter().map(|(_, v)| v)
+    }
+
+    /// Returns a mutable iterator over the values of the nodes in the tree, sorted by key.
+    pub fn values_mut(&mut self) -> impl Iterator<Item = &'_ mut V> {
+        self.iter_mut().map(|(_, v)| v)
+    }
+}
+
+impl<K, V> Default for RBTree<K, V> {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl<K, V> Drop for RBTree<K, V> {
+    fn drop(&mut self) {
+        // SAFETY: `root` is valid as it's embedded in `self` and we have a valid `self`.
+        let mut next = unsafe { bindings::rb_first_postorder(&self.root) };
+
+        // INVARIANT: The loop invariant is that all tree nodes from `next` in postorder are valid.
+        while !next.is_null() {
+            let this = crate::container_of!(next, Node<K, V>, links);
+
+            // Find out what the next node is before disposing of the current one.
+            // SAFETY: `next` and all nodes in postorder are still valid.
+            next = unsafe { bindings::rb_next_postorder(next) };
+
+            // INVARIANT: This is the destructor, so we break the type invariant during clean-up,
+            // but it is not observable. The loop invariant is still maintained.
+            // SAFETY: `this` is valid per the loop invariant.
+            unsafe { Box::from_raw(this as *mut Node<K, V>) };
+        }
+    }
+}
+
+impl<'a, K, V> IntoIterator for &'a RBTree<K, V> {
+    type Item = (&'a K, &'a V);
+    type IntoIter = RBTreeIterator<'a, K, V>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter()
+    }
+}
+
+/// An iterator over the nodes of a [`RBTree`].
+///
+/// Instances are created by calling [`RBTree::iter`].
+pub struct RBTreeIterator<'a, K, V> {
+    _tree: PhantomData<&'a RBTree<K, V>>,
+    next: *mut bindings::rb_node,
+}
+
+impl<'a, K, V> Iterator for RBTreeIterator<'a, K, V> {
+    type Item = (&'a K, &'a V);
+
+    fn next(&mut self) -> Option<Self::Item> {
+        if self.next.is_null() {
+            return None;
+        }
+
+        let cur = crate::container_of!(self.next, Node<K, V>, links);
+
+        // SAFETY: The reference to the tree used to create the iterator outlives the iterator, so
+        // the tree cannot change. By the tree invariant, all nodes are valid.
+        self.next = unsafe { bindings::rb_next(self.next) };
+
+        // SAFETY: By the same reasoning above, it is safe to dereference the node. Additionally,
+        // it is ok to return a reference to members because the iterator must outlive it.
+        Some(unsafe { (&(*cur).key, &(*cur).value) })
+    }
+}
+
+impl<'a, K, V> IntoIterator for &'a mut RBTree<K, V> {
+    type Item = (&'a K, &'a mut V);
+    type IntoIter = RBTreeIteratorMut<'a, K, V>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter_mut()
+    }
+}
+
+/// A mutable iterator over the nodes of a [`RBTree`].
+///
+/// Instances are created by calling [`RBTree::iter_mut`].
+pub struct RBTreeIteratorMut<'a, K, V> {
+    _tree: PhantomData<&'a RBTree<K, V>>,
+    next: *mut bindings::rb_node,
+}
+
+impl<'a, K, V> Iterator for RBTreeIteratorMut<'a, K, V> {
+    type Item = (&'a K, &'a mut V);
+
+    fn next(&mut self) -> Option<Self::Item> {
+        if self.next.is_null() {
+            return None;
+        }
+
+        let cur = crate::container_of!(self.next, Node<K, V>, links) as *mut Node<K, V>;
+
+        // SAFETY: The reference to the tree used to create the iterator outlives the iterator, so
+        // the tree cannot change (except for the value of previous nodes, but those don't affect
+        // the iteration process). By the tree invariant, all nodes are valid.
+        self.next = unsafe { bindings::rb_next(self.next) };
+
+        // SAFETY: By the same reasoning above, it is safe to dereference the node. Additionally,
+        // it is ok to return a reference to members because the iterator must outlive it.
+        Some(unsafe { (&(*cur).key, &mut (*cur).value) })
+    }
+}
+
+/// A memory reservation for a red-black tree node.
+///
+/// It contains the memory needed to hold a node that can be inserted into a red-black tree. One
+/// can be obtained by directly allocating it ([`RBTree::try_reserve_node`]) or by "uninitialising"
+/// ([`RBTreeNode::into_reservation`]) an actual node (usually returned by some operation like
+/// removal from a tree).
+pub struct RBTreeNodeReservation<K, V> {
+    node: Box<MaybeUninit<Node<K, V>>>,
+}
+
+impl<K, V> RBTreeNodeReservation<K, V> {
+    /// Initialises a node reservation.
+    ///
+    /// It then becomes an [`RBTreeNode`] that can be inserted into a tree.
+    pub fn into_node(mut self, key: K, value: V) -> RBTreeNode<K, V> {
+        let node_ptr = self.node.as_mut_ptr();
+        // SAFETY: `node_ptr` is valid, and so are its fields.
+        unsafe { addr_of_mut!((*node_ptr).links).write(bindings::rb_node::default()) };
+        // SAFETY: `node_ptr` is valid, and so are its fields.
+        unsafe { addr_of_mut!((*node_ptr).key).write(key) };
+        // SAFETY: `node_ptr` is valid, and so are its fields.
+        unsafe { addr_of_mut!((*node_ptr).value).write(value) };
+        let raw = Box::into_raw(self.node);
+        RBTreeNode {
+            // SAFETY: The pointer came from a `MaybeUninit<Node>` whose fields have all been
+            // initialised. Additionally, it has the same layout as `Node`.
+            node: unsafe { Box::from_raw(raw as _) },
+        }
+    }
+}
+
+/// A red-black tree node.
+///
+/// The node is fully initialised (with key and value) and can be inserted into a tree without any
+/// extra allocations or failure paths.
+pub struct RBTreeNode<K, V> {
+    node: Box<Node<K, V>>,
+}
+
+impl<K, V> RBTreeNode<K, V> {
+    /// "Uninitialises" a node.
+    ///
+    /// It then becomes a reservation that can be re-initialised into a different node (i.e., with
+    /// a different key and/or value).
+    ///
+    /// The existing key and value are dropped in-place as part of this operation, that is, memory
+    /// may be freed (but only for the key/value; memory for the node itself is kept for reuse).
+    pub fn into_reservation(self) -> RBTreeNodeReservation<K, V> {
+        let raw = Box::into_raw(self.node);
+        let mut ret = RBTreeNodeReservation {
+            // SAFETY: The pointer came from a valid `Node`, which has the same layout as
+            // `MaybeUninit<Node>`.
+            node: unsafe { Box::from_raw(raw as _) },
+        };
+        // SAFETY: Although the type is `MaybeUninit<Node>`, we know it has been initialised
+        // because it came from a `Node`. So it is safe to drop it.
+        unsafe { core::ptr::drop_in_place(ret.node.as_mut_ptr()) };
+        ret
+    }
+}
diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
new file mode 100644
index 00000000000..c38b0dceb34
--- /dev/null
+++ b/rust/kernel/security.rs
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Linux Security Modules (LSM).
+//!
+//! C header: [`include/linux/security.h`](../../../../include/linux/security.h).
+
+use crate::{bindings, c_types, error::Error, file::File, task::Task, Result};
+
+extern "C" {
+    #[allow(improper_ctypes)]
+    fn rust_helper_security_binder_set_context_mgr(
+        mgr: *mut bindings::task_struct,
+    ) -> c_types::c_int;
+    #[allow(improper_ctypes)]
+    fn rust_helper_security_binder_transaction(
+        from: *mut bindings::task_struct,
+        to: *mut bindings::task_struct,
+    ) -> c_types::c_int;
+    #[allow(improper_ctypes)]
+    fn rust_helper_security_binder_transfer_binder(
+        from: *mut bindings::task_struct,
+        to: *mut bindings::task_struct,
+    ) -> c_types::c_int;
+    #[allow(improper_ctypes)]
+    fn rust_helper_security_binder_transfer_file(
+        from: *mut bindings::task_struct,
+        to: *mut bindings::task_struct,
+        file: *mut bindings::file,
+    ) -> c_types::c_int;
+}
+
+/// Calls the security modules to determine if the given task can become the manager of a binder
+/// context.
+pub fn binder_set_context_mgr(mgr: &Task) -> Result {
+    // SAFETY: By the `Task` invariants, `mgr.ptr` is valid.
+    let ret = unsafe { rust_helper_security_binder_set_context_mgr(mgr.ptr) };
+    if ret != 0 {
+        Err(Error::from_kernel_errno(ret))
+    } else {
+        Ok(())
+    }
+}
+
+/// Calls the security modules to determine if binder transactions are allowed from task `from` to
+/// task `to`.
+pub fn binder_transaction(from: &Task, to: &Task) -> Result {
+    // SAFETY: By the `Task` invariants, `from.ptr` and `to.ptr` are valid.
+    let ret = unsafe { rust_helper_security_binder_transaction(from.ptr, to.ptr) };
+    if ret != 0 {
+        Err(Error::from_kernel_errno(ret))
+    } else {
+        Ok(())
+    }
+}
+
+/// Calls the security modules to determine if task `from` is allowed to send binder objects
+/// (owned by itself or other processes) to task `to` through a binder transaction.
+pub fn binder_transfer_binder(from: &Task, to: &Task) -> Result {
+    // SAFETY: By the `Task` invariants, `from.ptr` and `to.ptr` are valid.
+    let ret = unsafe { rust_helper_security_binder_transfer_binder(from.ptr, to.ptr) };
+    if ret != 0 {
+        Err(Error::from_kernel_errno(ret))
+    } else {
+        Ok(())
+    }
+}
+
+/// Calls the security modules to determine if task `from` is allowed to send the given file to
+/// task `to` (which would get its own file descriptor) through a binder transaction.
+pub fn binder_transfer_file(from: &Task, to: &Task, file: &File) -> Result {
+    // SAFETY: By the `Task` invariants, `from.ptr` and `to.ptr` are valid. Similarly, by the
+    // `File` invariants, `file.ptr` is also valid.
+    let ret = unsafe { rust_helper_security_binder_transfer_file(from.ptr, to.ptr, file.ptr) };
+    if ret != 0 {
+        Err(Error::from_kernel_errno(ret))
+    } else {
+        Ok(())
+    }
+}
diff --git a/rust/kernel/static_assert.rs b/rust/kernel/static_assert.rs
new file mode 100644
index 00000000000..a80d8ab5756
--- /dev/null
+++ b/rust/kernel/static_assert.rs
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Static assert.
+
+/// Static assert (i.e. compile-time assert).
+///
+/// Similar to C11 [`_Static_assert`] and C++11 [`static_assert`].
+///
+/// The feature may be added to Rust in the future: see [RFC 2790].
+///
+/// [`_Static_assert`]: https://en.cppreference.com/w/c/language/_Static_assert
+/// [`static_assert`]: https://en.cppreference.com/w/cpp/language/static_assert
+/// [RFC 2790]: https://github.com/rust-lang/rfcs/issues/2790
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// static_assert!(42 > 24);
+/// static_assert!(core::mem::size_of::<u8>() == 1);
+///
+/// const X: &[u8] = b"bar";
+/// static_assert!(X[1] == 'a' as u8);
+///
+/// const fn f(x: i32) -> i32 {
+///     x + 2
+/// }
+/// static_assert!(f(40) == 42);
+/// ```
+#[macro_export]
+macro_rules! static_assert {
+    ($condition:expr) => {
+        // Based on the latest one in `rustc`'s one before it was [removed].
+        //
+        // [removed]: https://github.com/rust-lang/rust/commit/c2dad1c6b9f9636198d7c561b47a2974f5103f6d
+        #[allow(dead_code)]
+        const _: () = [()][!($condition) as usize];
+    };
+}
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
new file mode 100644
index 00000000000..5620080a8e8
--- /dev/null
+++ b/rust/kernel/str.rs
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! String representations.
+
+use core::ops::{self, Deref, Index};
+
+use crate::bindings;
+use crate::c_types;
+
+/// Byte string without UTF-8 validity guarantee.
+///
+/// `BStr` is simply an alias to `[u8]`, but has a more evident semantical meaning.
+pub type BStr = [u8];
+
+/// Creates a new [`BStr`] from a string literal.
+///
+/// `b_str!` converts the supplied string literal to byte string, so non-ASCII
+/// characters can be included.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::b_str;
+/// # use kernel::str::BStr;
+/// const MY_BSTR: &'static BStr = b_str!("My awesome BStr!");
+/// ```
+#[macro_export]
+macro_rules! b_str {
+    ($str:literal) => {{
+        const S: &'static str = $str;
+        const C: &'static $crate::str::BStr = S.as_bytes();
+        C
+    }};
+}
+
+/// Possible errors when using conversion functions in [`CStr`].
+#[derive(Debug, Clone, Copy)]
+pub enum CStrConvertError {
+    /// Supplied bytes contain an interior `NUL`.
+    InteriorNul,
+
+    /// Supplied bytes are not terminated by `NUL`.
+    NotNulTerminated,
+}
+
+impl From<CStrConvertError> for crate::Error {
+    #[inline]
+    fn from(_: CStrConvertError) -> crate::Error {
+        crate::Error::EINVAL
+    }
+}
+
+/// A string that is guaranteed to have exactly one `NUL` byte, which is at the
+/// end.
+///
+/// Used for interoperability with kernel APIs that take C strings.
+#[repr(transparent)]
+pub struct CStr([u8]);
+
+impl CStr {
+    /// Returns the length of this string excluding `NUL`.
+    #[inline]
+    pub const fn len(&self) -> usize {
+        self.len_with_nul() - 1
+    }
+
+    /// Returns the length of this string with `NUL`.
+    #[inline]
+    pub const fn len_with_nul(&self) -> usize {
+        // SAFETY: This is one of the invariant of `CStr`.
+        // We add a `unreachable_unchecked` here to hint the optimizer that
+        // the value returned from this function is non-zero.
+        if self.0.is_empty() {
+            unsafe { core::hint::unreachable_unchecked() };
+        }
+        self.0.len()
+    }
+
+    /// Returns `true` if the string only includes `NUL`.
+    #[inline]
+    pub const fn is_empty(&self) -> bool {
+        self.len() == 0
+    }
+
+    /// Wraps a raw C string pointer.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be a valid pointer to a `NUL`-terminated C string, and it must
+    /// last at least `'a`. When `CStr` is alive, the memory pointed by `ptr`
+    /// must not be mutated.
+    #[inline]
+    pub unsafe fn from_char_ptr<'a>(ptr: *const c_types::c_char) -> &'a Self {
+        // SAFETY: The safety precondition guarantees `ptr` is a valid pointer
+        // to a `NUL`-terminated C string.
+        let len = unsafe { bindings::strlen(ptr) } + 1;
+        // SAFETY: Lifetime guaranteed by the safety precondition.
+        let bytes = unsafe { core::slice::from_raw_parts(ptr as _, len as _) };
+        // SAFETY: As `len` is returned by `strlen`, `bytes` does not contain interior `NUL`.
+        // As we have added 1 to `len`, the last byte is known to be `NUL`.
+        unsafe { Self::from_bytes_with_nul_unchecked(bytes) }
+    }
+
+    /// Creates a [`CStr`] from a `[u8]`.
+    ///
+    /// The provided slice must be `NUL`-terminated, does not contain any
+    /// interior `NUL` bytes.
+    pub const fn from_bytes_with_nul(bytes: &[u8]) -> Result<&Self, CStrConvertError> {
+        if bytes.is_empty() {
+            return Err(CStrConvertError::NotNulTerminated);
+        }
+        if bytes[bytes.len() - 1] != 0 {
+            return Err(CStrConvertError::NotNulTerminated);
+        }
+        let mut i = 0;
+        // `i + 1 < bytes.len()` allows LLVM to optimize away bounds checking,
+        // while it couldn't optimize away bounds checks for `i < bytes.len() - 1`.
+        while i + 1 < bytes.len() {
+            if bytes[i] == 0 {
+                return Err(CStrConvertError::InteriorNul);
+            }
+            i += 1;
+        }
+        // SAFETY: We just checked that all properties hold.
+        Ok(unsafe { Self::from_bytes_with_nul_unchecked(bytes) })
+    }
+
+    /// Creates a [`CStr`] from a `[u8]`, panic if input is not valid.
+    ///
+    /// This function is only meant to be used by `c_str!` macro, so
+    /// crates using `c_str!` macro don't have to enable `const_panic` feature.
+    #[doc(hidden)]
+    pub const fn from_bytes_with_nul_unwrap(bytes: &[u8]) -> &Self {
+        match Self::from_bytes_with_nul(bytes) {
+            Ok(v) => v,
+            Err(_) => panic!("string contains interior NUL"),
+        }
+    }
+
+    /// Creates a [`CStr`] from a `[u8]` without performing any additional
+    /// checks.
+    ///
+    /// # Safety
+    ///
+    /// `bytes` *must* end with a `NUL` byte, and should only have a single
+    /// `NUL` byte (or the string will be truncated).
+    #[inline]
+    pub const unsafe fn from_bytes_with_nul_unchecked(bytes: &[u8]) -> &CStr {
+        // Note: This can be done using pointer deref (which requires
+        // `const_raw_ptr_deref` to be const) or `transmute` (which requires
+        // `const_transmute` to be const) or `ptr::from_raw_parts` (which
+        // requires `ptr_metadata`).
+        // While none of them are current stable, it is very likely that one of
+        // them will eventually be.
+        // SAFETY: Properties of `bytes` guaranteed by the safety precondition.
+        unsafe { &*(bytes as *const [u8] as *const Self) }
+    }
+
+    /// Returns a C pointer to the string.
+    #[inline]
+    pub const fn as_char_ptr(&self) -> *const c_types::c_char {
+        self.0.as_ptr() as _
+    }
+
+    /// Convert the string to a byte slice without the trailing 0 byte.
+    #[inline]
+    pub fn as_bytes(&self) -> &[u8] {
+        &self.0[..self.len()]
+    }
+
+    /// Convert the string to a byte slice containing the trailing 0 byte.
+    #[inline]
+    pub const fn as_bytes_with_nul(&self) -> &[u8] {
+        &self.0
+    }
+}
+
+impl AsRef<BStr> for CStr {
+    #[inline]
+    fn as_ref(&self) -> &BStr {
+        self.as_bytes()
+    }
+}
+
+impl Deref for CStr {
+    type Target = BStr;
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        self.as_bytes()
+    }
+}
+
+impl Index<ops::RangeFrom<usize>> for CStr {
+    type Output = CStr;
+
+    #[inline]
+    fn index(&self, index: ops::RangeFrom<usize>) -> &Self::Output {
+        // Delegate bounds checking to slice.
+        // Assign to _ to mute clippy's unnecessary operation warning.
+        let _ = &self.as_bytes()[index.start..];
+        // SAFETY: We just checked the bounds.
+        unsafe { Self::from_bytes_with_nul_unchecked(&self.0[index.start..]) }
+    }
+}
+
+impl Index<ops::RangeFull> for CStr {
+    type Output = CStr;
+
+    #[inline]
+    fn index(&self, _index: ops::RangeFull) -> &Self::Output {
+        self
+    }
+}
+
+mod private {
+    use core::ops;
+
+    //  Marker trait for index types that can be forward to `BStr`.
+    pub trait CStrIndex {}
+
+    impl CStrIndex for usize {}
+    impl CStrIndex for ops::Range<usize> {}
+    impl CStrIndex for ops::RangeInclusive<usize> {}
+    impl CStrIndex for ops::RangeToInclusive<usize> {}
+}
+
+impl<Idx> Index<Idx> for CStr
+where
+    Idx: private::CStrIndex,
+    BStr: Index<Idx>,
+{
+    type Output = <BStr as Index<Idx>>::Output;
+
+    #[inline]
+    fn index(&self, index: Idx) -> &Self::Output {
+        &self.as_bytes()[index]
+    }
+}
+
+/// Creates a new [`CStr`] from a string literal.
+///
+/// The string literal should not contain any `NUL` bytes.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::c_str;
+/// # use kernel::str::CStr;
+/// const MY_CSTR: &'static CStr = c_str!("My awesome CStr!");
+/// ```
+#[macro_export]
+macro_rules! c_str {
+    ($str:literal) => {{
+        const S: &str = concat!($str, "\0");
+        const C: &$crate::str::CStr = $crate::str::CStr::from_bytes_with_nul_unwrap(S.as_bytes());
+        C
+    }};
+}
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
new file mode 100644
index 00000000000..ddecb9e371a
--- /dev/null
+++ b/rust/kernel/sync/arc.rs
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A reference-counted pointer.
+//!
+//! This module implements a way for users to create reference-counted objects and pointers to
+//! them. Such a pointer automatically increments and decrements the count, and drops the
+//! underlying object when it reaches zero. It is also safe to use concurrently from multiple
+//! threads.
+//!
+//! It is different from the standard library's [`Arc`] in a few ways:
+//! 1. It is backed by the kernel's `refcount_t` type.
+//! 2. It does not support weak references, which allows it to be half the size.
+//! 3. It saturates the reference count instead of aborting when it goes over a threshold.
+//! 4. It does not provide a `get_mut` method, so the ref counted object is pinned.
+//!
+//! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
+
+use crate::{bindings, Result};
+use alloc::boxed::Box;
+use core::{
+    cell::UnsafeCell, convert::AsRef, marker::PhantomData, mem::ManuallyDrop, ops::Deref, pin::Pin,
+    ptr::NonNull,
+};
+
+extern "C" {
+    fn rust_helper_refcount_new() -> bindings::refcount_t;
+    fn rust_helper_refcount_inc(r: *mut bindings::refcount_t);
+    fn rust_helper_refcount_dec_and_test(r: *mut bindings::refcount_t) -> bool;
+}
+
+/// A reference-counted pointer to an instance of `T`.
+///
+/// The reference count is incremented when new instances of [`Ref`] are created, and decremented
+/// when they are dropped. When the count reaches zero, the underlying `T` is also dropped.
+///
+/// # Invariants
+///
+/// The reference count on an instance of [`Ref`] is always non-zero.
+/// The object pointed to by [`Ref`] is always pinned.
+pub struct Ref<T: ?Sized> {
+    ptr: NonNull<RefInner<T>>,
+    _p: PhantomData<RefInner<T>>,
+}
+
+struct RefInner<T: ?Sized> {
+    refcount: UnsafeCell<bindings::refcount_t>,
+    data: T,
+}
+
+// This is to allow [`Ref`] (and variants) to be used as the type of `self`.
+impl<T: ?Sized> core::ops::Receiver for Ref<T> {}
+
+// SAFETY: It is safe to send `Ref<T>` to another thread when the underlying `T` is `Sync` because
+// it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
+// `T` to be `Send` because any thread that has a `Ref<T>` may ultimately access `T` directly, for
+// example, when the reference count reaches zero and `T` is dropped.
+unsafe impl<T: ?Sized + Sync + Send> Send for Ref<T> {}
+
+// SAFETY: It is safe to send `&Ref<T>` to another thread when the underlying `T` is `Sync` for
+// the same reason as above. `T` needs to be `Send` as well because a thread can clone a `&Ref<T>`
+// into a `Ref<T>`, which may lead to `T` being accessed by the same reasoning as above.
+unsafe impl<T: ?Sized + Sync + Send> Sync for Ref<T> {}
+
+impl<T> Ref<T> {
+    /// Constructs a new reference counted instance of `T`.
+    pub fn try_new(contents: T) -> Result<Self> {
+        Self::try_new_and_init(contents, |_| {})
+    }
+
+    /// Constructs a new reference counted instance of `T` and calls the initialisation function.
+    ///
+    /// This is useful because it provides a mutable reference to `T` at its final location.
+    pub fn try_new_and_init<U: FnOnce(Pin<&mut T>)>(contents: T, init: U) -> Result<Self> {
+        // INVARIANT: The refcount is initialised to a non-zero value.
+        let mut inner = Box::try_new(RefInner {
+            // SAFETY: Just an FFI call that returns a `refcount_t` initialised to 1.
+            refcount: UnsafeCell::new(unsafe { rust_helper_refcount_new() }),
+            data: contents,
+        })?;
+
+        // SAFETY: By the invariant, `RefInner` is pinned and `T` is also pinned.
+        let pinned = unsafe { Pin::new_unchecked(&mut inner.data) };
+
+        // INVARIANT: The only places where `&mut T` is available are here, which is explicitly
+        // pinned, and in `drop`. Both are compatible with the pin requirements.
+        init(pinned);
+
+        Ok(Ref {
+            ptr: NonNull::from(Box::leak(inner)),
+            _p: PhantomData,
+        })
+    }
+
+    /// Deconstructs a [`Ref`] object into a `usize`.
+    ///
+    /// It can be reconstructed once via [`Ref::from_usize`].
+    pub fn into_usize(obj: Self) -> usize {
+        ManuallyDrop::new(obj).ptr.as_ptr() as _
+    }
+
+    /// Borrows a [`Ref`] instance previously deconstructed via [`Ref::into_usize`].
+    ///
+    /// # Safety
+    ///
+    /// `encoded` must have been returned by a previous call to [`Ref::into_usize`]. Additionally,
+    /// [`Ref::from_usize`] can only be called after *all* instances of [`RefBorrow`] have been
+    /// dropped.
+    pub unsafe fn borrow_usize(encoded: usize) -> RefBorrow<T> {
+        // SAFETY: By the safety requirement of this function, we know that `encoded` came from
+        // a previous call to `Ref::into_usize`.
+        let obj = ManuallyDrop::new(unsafe { Ref::from_usize(encoded) });
+
+        // SAFEY: The safety requirements ensure that the object remains alive for the lifetime of
+        // the returned value. There is no way to create mutable references to the object.
+        unsafe { RefBorrow::new(obj) }
+    }
+
+    /// Recreates a [`Ref`] instance previously deconstructed via [`Ref::into_usize`].
+    ///
+    /// # Safety
+    ///
+    /// `encoded` must have been returned by a previous call to [`Ref::into_usize`]. Additionally,
+    /// it can only be called once for each previous call to [``Ref::into_usize`].
+    pub unsafe fn from_usize(encoded: usize) -> Self {
+        Ref {
+            ptr: NonNull::new(encoded as _).unwrap(),
+            _p: PhantomData,
+        }
+    }
+}
+
+impl<T: ?Sized> Ref<T> {
+    /// Determines if two reference-counted pointers point to the same underlying instance of `T`.
+    pub fn ptr_eq(a: &Self, b: &Self) -> bool {
+        core::ptr::eq(a.ptr.as_ptr(), b.ptr.as_ptr())
+    }
+
+    /// Returns a pinned version of a given `Ref` instance.
+    pub fn pinned(obj: Self) -> Pin<Self> {
+        // SAFETY: The type invariants guarantee that the value is pinned.
+        unsafe { Pin::new_unchecked(obj) }
+    }
+}
+
+impl<T: ?Sized> Deref for Ref<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
+        // safe to dereference it.
+        unsafe { &self.ptr.as_ref().data }
+    }
+}
+
+impl<T: ?Sized> Clone for Ref<T> {
+    fn clone(&self) -> Self {
+        // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot overflow to zero.
+        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
+        // safe to increment the refcount.
+        unsafe { rust_helper_refcount_inc(self.ptr.as_ref().refcount.get()) };
+        Self {
+            ptr: self.ptr,
+            _p: PhantomData,
+        }
+    }
+}
+
+impl<T: ?Sized> AsRef<T> for Ref<T> {
+    fn as_ref(&self) -> &T {
+        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
+        // safe to dereference it.
+        unsafe { &self.ptr.as_ref().data }
+    }
+}
+
+impl<T: ?Sized> Drop for Ref<T> {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariant, there is necessarily a reference to the object. We cannot
+        // touch `refcount` after it's decremented to a non-zero value because another thread/CPU
+        // may concurrently decrement it to zero and free it. It is ok to have a raw pointer to
+        // freed/invalid memory as long as it is never dereferenced.
+        let refcount = unsafe { self.ptr.as_ref() }.refcount.get();
+
+        // INVARIANT: If the refcount reaches zero, there are no other instances of `Ref`, and
+        // this instance is being dropped, so the broken invariant is not observable.
+        // SAFETY: Also by the type invariant, we are allowed to decrement the refcount.
+        let is_zero = unsafe { rust_helper_refcount_dec_and_test(refcount) };
+        if is_zero {
+            // The count reached zero, we must free the memory.
+            //
+            // SAFETY: The pointer was initialised from the result of `Box::leak`.
+            unsafe { Box::from_raw(self.ptr.as_ptr()) };
+        }
+    }
+}
+
+/// A borrowed [`Ref`] with manually-managed lifetime.
+///
+/// # Invariants
+///
+/// There are no mutable references to the underlying [`Ref`], and it remains valid for the lifetime
+/// of the [`RefBorrow`] instance.
+pub struct RefBorrow<T: ?Sized> {
+    inner_ref: ManuallyDrop<Ref<T>>,
+}
+
+impl<T: ?Sized> RefBorrow<T> {
+    /// Creates a new [`RefBorrow`] instance.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure the following for the lifetime of the returned [`RefBorrow`] instance:
+    /// 1. That `obj` remains valid;
+    /// 2. That no mutable references to `obj` are created.
+    unsafe fn new(obj: ManuallyDrop<Ref<T>>) -> Self {
+        // INVARIANT: The safety requirements guarantee the invariants.
+        Self { inner_ref: obj }
+    }
+}
+
+impl<T: ?Sized> Deref for RefBorrow<T> {
+    type Target = Ref<T>;
+
+    fn deref(&self) -> &Self::Target {
+        self.inner_ref.deref()
+    }
+}
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
new file mode 100644
index 00000000000..993087e6c23
--- /dev/null
+++ b/rust/kernel/sync/condvar.rs
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A condition variable.
+//!
+//! This module allows Rust code to use the kernel's [`struct wait_queue_head`] as a condition
+//! variable.
+
+use super::{Guard, Lock, NeedsLockClass};
+use crate::{bindings, str::CStr, task::Task};
+use core::{cell::UnsafeCell, marker::PhantomPinned, mem::MaybeUninit, pin::Pin};
+
+extern "C" {
+    fn rust_helper_init_wait(wq: *mut bindings::wait_queue_entry);
+}
+
+/// Safely initialises a [`CondVar`] with the given name, generating a new lock class.
+#[macro_export]
+macro_rules! condvar_init {
+    ($condvar:expr, $name:literal) => {
+        $crate::init_with_lockdep!($condvar, $name)
+    };
+}
+
+// TODO: `bindgen` is not generating this constant. Figure out why.
+const POLLFREE: u32 = 0x4000;
+
+/// Exposes the kernel's [`struct wait_queue_head`] as a condition variable. It allows the caller to
+/// atomically release the given lock and go to sleep. It reacquires the lock when it wakes up. And
+/// it wakes up when notified by another thread (via [`CondVar::notify_one`] or
+/// [`CondVar::notify_all`]) or because the thread received a signal.
+///
+/// [`struct wait_queue_head`]: ../../../include/linux/wait.h
+pub struct CondVar {
+    pub(crate) wait_list: UnsafeCell<bindings::wait_queue_head>,
+
+    /// A condvar needs to be pinned because it contains a [`struct list_head`] that is
+    /// self-referential, so it cannot be safely moved once it is initialised.
+    _pin: PhantomPinned,
+}
+
+// SAFETY: `CondVar` only uses a `struct wait_queue_head`, which is safe to use on any thread.
+unsafe impl Send for CondVar {}
+
+// SAFETY: `CondVar` only uses a `struct wait_queue_head`, which is safe to use on multiple threads
+// concurrently.
+unsafe impl Sync for CondVar {}
+
+impl CondVar {
+    /// Constructs a new conditional variable.
+    ///
+    /// # Safety
+    ///
+    /// The caller must call `CondVar::init` before using the conditional variable.
+    pub unsafe fn new() -> Self {
+        Self {
+            wait_list: UnsafeCell::new(bindings::wait_queue_head::default()),
+            _pin: PhantomPinned,
+        }
+    }
+
+    /// Atomically releases the given lock (whose ownership is proven by the guard) and puts the
+    /// thread to sleep. It wakes up when notified by [`CondVar::notify_one`] or
+    /// [`CondVar::notify_all`], or when the thread receives a signal.
+    ///
+    /// Returns whether there is a signal pending.
+    #[must_use = "wait returns if a signal is pending, so the caller must check the return value"]
+    pub fn wait<L: Lock>(&self, guard: &mut Guard<'_, L>) -> bool {
+        let lock = guard.lock;
+        let mut wait = MaybeUninit::<bindings::wait_queue_entry>::uninit();
+
+        // SAFETY: `wait` points to valid memory.
+        unsafe { rust_helper_init_wait(wait.as_mut_ptr()) };
+
+        // SAFETY: Both `wait` and `wait_list` point to valid memory.
+        unsafe {
+            bindings::prepare_to_wait_exclusive(
+                self.wait_list.get(),
+                wait.as_mut_ptr(),
+                bindings::TASK_INTERRUPTIBLE as _,
+            );
+        }
+
+        // SAFETY: The guard is evidence that the caller owns the lock.
+        unsafe { lock.unlock() };
+
+        // SAFETY: No arguments, switches to another thread.
+        unsafe { bindings::schedule() };
+
+        lock.lock_noguard();
+
+        // SAFETY: Both `wait` and `wait_list` point to valid memory.
+        unsafe { bindings::finish_wait(self.wait_list.get(), wait.as_mut_ptr()) };
+
+        Task::current().signal_pending()
+    }
+
+    /// Calls the kernel function to notify the appropriate number of threads with the given flags.
+    fn notify(&self, count: i32, flags: u32) {
+        // SAFETY: `wait_list` points to valid memory.
+        unsafe {
+            bindings::__wake_up(
+                self.wait_list.get(),
+                bindings::TASK_NORMAL,
+                count,
+                flags as _,
+            )
+        };
+    }
+
+    /// Wakes a single waiter up, if any. This is not 'sticky' in the sense that if no thread is
+    /// waiting, the notification is lost completely (as opposed to automatically waking up the
+    /// next waiter).
+    pub fn notify_one(&self) {
+        self.notify(1, 0);
+    }
+
+    /// Wakes all waiters up, if any. This is not 'sticky' in the sense that if no thread is
+    /// waiting, the notification is lost completely (as opposed to automatically waking up the
+    /// next waiter).
+    pub fn notify_all(&self) {
+        self.notify(0, 0);
+    }
+
+    /// Wakes all waiters up. If they were added by `epoll`, they are also removed from the list of
+    /// waiters. This is useful when cleaning up a condition variable that may be waited on by
+    /// threads that use `epoll`.
+    pub fn free_waiters(&self) {
+        self.notify(1, bindings::POLLHUP | POLLFREE);
+    }
+}
+
+impl NeedsLockClass for CondVar {
+    unsafe fn init(self: Pin<&mut Self>, name: &'static CStr, key: *mut bindings::lock_class_key) {
+        unsafe { bindings::__init_waitqueue_head(self.wait_list.get(), name.as_char_ptr(), key) };
+    }
+}
diff --git a/rust/kernel/sync/guard.rs b/rust/kernel/sync/guard.rs
new file mode 100644
index 00000000000..84e5d319a5f
--- /dev/null
+++ b/rust/kernel/sync/guard.rs
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A generic lock guard and trait.
+//!
+//! This module contains a lock guard that can be used with any locking primitive that implements
+//! the ([`Lock`]) trait. It also contains the definition of the trait, which can be leveraged by
+//! other constructs to work on generic locking primitives.
+
+/// Allows mutual exclusion primitives that implement the [`Lock`] trait to automatically unlock
+/// when a guard goes out of scope. It also provides a safe and convenient way to access the data
+/// protected by the lock.
+#[must_use = "the lock unlocks immediately when the guard is unused"]
+pub struct Guard<'a, L: Lock + ?Sized> {
+    pub(crate) lock: &'a L,
+}
+
+// SAFETY: `Guard` is sync when the data protected by the lock is also sync. This is more
+// conservative than the default compiler implementation; more details can be found on
+// https://github.com/rust-lang/rust/issues/41622 -- it refers to `MutexGuard` from the standard
+// library.
+unsafe impl<L> Sync for Guard<'_, L>
+where
+    L: Lock + ?Sized,
+    L::Inner: Sync,
+{
+}
+
+impl<L: Lock + ?Sized> core::ops::Deref for Guard<'_, L> {
+    type Target = L::Inner;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: The caller owns the lock, so it is safe to deref the protected data.
+        unsafe { &*self.lock.locked_data().get() }
+    }
+}
+
+impl<L: Lock + ?Sized> core::ops::DerefMut for Guard<'_, L> {
+    fn deref_mut(&mut self) -> &mut L::Inner {
+        // SAFETY: The caller owns the lock, so it is safe to deref the protected data.
+        unsafe { &mut *self.lock.locked_data().get() }
+    }
+}
+
+impl<L: Lock + ?Sized> Drop for Guard<'_, L> {
+    fn drop(&mut self) {
+        // SAFETY: The caller owns the lock, so it is safe to unlock it.
+        unsafe { self.lock.unlock() };
+    }
+}
+
+impl<'a, L: Lock + ?Sized> Guard<'a, L> {
+    /// Constructs a new lock guard.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that it owns the lock.
+    pub(crate) unsafe fn new(lock: &'a L) -> Self {
+        Self { lock }
+    }
+}
+
+/// A generic mutual exclusion primitive.
+///
+/// [`Guard`] is written such that any mutual exclusion primitive that can implement this trait can
+/// also benefit from having an automatic way to unlock itself.
+pub trait Lock {
+    /// The type of the data protected by the lock.
+    type Inner: ?Sized;
+
+    /// Acquires the lock, making the caller its owner.
+    fn lock_noguard(&self);
+
+    /// Releases the lock, giving up ownership of the lock.
+    ///
+    /// # Safety
+    ///
+    /// It must only be called by the current owner of the lock.
+    unsafe fn unlock(&self);
+
+    /// Returns the data protected by the lock.
+    fn locked_data(&self) -> &core::cell::UnsafeCell<Self::Inner>;
+}
diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.rs
new file mode 100644
index 00000000000..d3e0b0d5e9b
--- /dev/null
+++ b/rust/kernel/sync/locked_by.rs
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A wrapper for data protected by a lock that does not wrap it.
+
+use super::{Guard, Lock};
+use core::{cell::UnsafeCell, ops::Deref, ptr};
+
+/// Allows access to some data to be serialised by a lock that does not wrap it.
+///
+/// In most cases, data protected by a lock is wrapped by the appropriate lock type, e.g.,
+/// [`super::Mutex`] or [`super::SpinLock`]. [`LockedBy`] is meant for cases when this is not
+/// possible. For example, if a container has a lock and some data in the contained elements needs
+/// to be protected by the same lock.
+///
+/// [`LockedBy`] wraps the data in lieu of another locking primitive, and only allows access to it
+/// when the caller shows evidence that 'external' lock is locked.
+///
+/// # Example
+///
+/// The following is an example for illustrative purposes: `InnerDirectory::bytes_used` is an
+/// aggregate of all `InnerFile::bytes_used` and must be kept consistent; so we wrap `InnerFile` in
+/// a `LockedBy` so that it shares a lock with `InnerDirectory`. This allows us to enforce at
+/// compile-time that access to `InnerFile` is only granted when an `InnerDirectory` is also
+/// locked; we enforce at run time that the right `InnerDirectory` is locked.
+///
+/// ```
+/// # use kernel::prelude::*;
+/// use kernel::sync::{LockedBy, Mutex};
+///
+/// struct InnerFile {
+///     bytes_used: u64,
+/// }
+///
+/// struct File {
+///     name: String,
+///     inner: LockedBy<InnerFile, Mutex<InnerDirectory>>,
+/// }
+///
+/// struct InnerDirectory {
+///     /// The sum of the bytes used by all files.
+///     bytes_used: u64,
+///     files: Vec<File>,
+/// }
+///
+/// struct Directory {
+///     name: String,
+///     inner: Mutex<InnerDirectory>,
+/// }
+/// ```
+pub struct LockedBy<T: ?Sized, L: Lock + ?Sized> {
+    owner: *const L::Inner,
+    data: UnsafeCell<T>,
+}
+
+// SAFETY: `LockedBy` can be transferred across thread boundaries iff the data it protects can.
+unsafe impl<T: ?Sized + Send, L: Lock + ?Sized> Send for LockedBy<T, L> {}
+
+// SAFETY: `LockedBy` serialises the interior mutability it provides, so it is `Sync` as long as the
+// data it protects is `Send`.
+unsafe impl<T: ?Sized + Send, L: Lock + ?Sized> Sync for LockedBy<T, L> {}
+
+impl<T, L: Lock + ?Sized> LockedBy<T, L> {
+    /// Constructs a new instance of [`LockedBy`].
+    ///
+    /// It stores a raw pointer to the owner that is never dereferenced. It is only used to ensure
+    /// that the right owner is being used to access the protected data. If the owner is freed, the
+    /// data becomes inaccessible; if another instance of the owner is allocated *on the same
+    /// memory location*, the data becomes accessible again: none of this affects memory safety
+    /// because in any case at most one thread (or CPU) can access the protected data at a time.
+    pub fn new(owner: &L, data: T) -> Self {
+        Self {
+            owner: owner.locked_data().get(),
+            data: UnsafeCell::new(data),
+        }
+    }
+}
+
+impl<T: ?Sized, L: Lock + ?Sized> LockedBy<T, L> {
+    /// Returns a reference to the protected data when the caller provides evidence (via a
+    /// [`Guard`]) that the owner is locked.
+    pub fn access<'a>(&'a self, guard: &'a Guard<'_, L>) -> &'a T {
+        if !ptr::eq(guard.deref(), self.owner) {
+            panic!("guard does not match owner");
+        }
+
+        // SAFETY: `guard` is evidence that the owner is locked.
+        unsafe { &mut *self.data.get() }
+    }
+
+    /// Returns a mutable reference to the protected data when the caller provides evidence (via a
+    /// mutable [`Guard`]) that the owner is locked mutably.
+    pub fn access_mut<'a>(&'a self, guard: &'a mut Guard<'_, L>) -> &'a mut T {
+        if !ptr::eq(guard.deref().deref(), self.owner) {
+            panic!("guard does not match owner");
+        }
+
+        // SAFETY: `guard` is evidence that the owner is locked.
+        unsafe { &mut *self.data.get() }
+    }
+
+    /// Returns a mutable reference to the protected data when the caller provides evidence (via a
+    /// mutable owner) that the owner is locked mutably. Showing a mutable reference to the owner
+    /// is sufficient because we know no other references can exist to it.
+    pub fn access_from_mut<'a>(&'a self, owner: &'a mut L::Inner) -> &'a mut T {
+        if !ptr::eq(owner, self.owner) {
+            panic!("mismatched owners");
+        }
+
+        // SAFETY: `owner` is evidence that there is only one reference to the owner.
+        unsafe { &mut *self.data.get() }
+    }
+}
diff --git a/rust/kernel/sync/mod.rs b/rust/kernel/sync/mod.rs
new file mode 100644
index 00000000000..ce863109c06
--- /dev/null
+++ b/rust/kernel/sync/mod.rs
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Synchronisation primitives.
+//!
+//! This module contains the kernel APIs related to synchronisation that have been ported or
+//! wrapped for usage by Rust code in the kernel and is shared by all of them.
+//!
+//! # Example
+//!
+//! ```no_run
+//! # use kernel::prelude::*;
+//! # use kernel::mutex_init;
+//! # use kernel::sync::Mutex;
+//! # use alloc::boxed::Box;
+//! # use core::pin::Pin;
+//! // SAFETY: `init` is called below.
+//! let mut data = Pin::from(Box::new(unsafe { Mutex::new(0) }));
+//! mutex_init!(data.as_mut(), "test::data");
+//! *data.lock() = 10;
+//! pr_info!("{}\n", *data.lock());
+//! ```
+
+use crate::str::CStr;
+use crate::{bindings, c_types};
+use core::pin::Pin;
+
+mod arc;
+mod condvar;
+mod guard;
+mod locked_by;
+mod mutex;
+mod spinlock;
+
+pub use arc::{Ref, RefBorrow};
+pub use condvar::CondVar;
+pub use guard::{Guard, Lock};
+pub use locked_by::LockedBy;
+pub use mutex::Mutex;
+pub use spinlock::SpinLock;
+
+extern "C" {
+    fn rust_helper_cond_resched() -> c_types::c_int;
+}
+
+/// Safely initialises an object that has an `init` function that takes a name and a lock class as
+/// arguments, examples of these are [`Mutex`] and [`SpinLock`]. Each of them also provides a more
+/// specialised name that uses this macro.
+#[doc(hidden)]
+#[macro_export]
+macro_rules! init_with_lockdep {
+    ($obj:expr, $name:literal) => {{
+        static mut CLASS: core::mem::MaybeUninit<$crate::bindings::lock_class_key> =
+            core::mem::MaybeUninit::uninit();
+        let obj = $obj;
+        let name = $crate::c_str!($name);
+        // SAFETY: `CLASS` is never used by Rust code directly; the kernel may change it though.
+        #[allow(unused_unsafe)]
+        unsafe {
+            $crate::sync::NeedsLockClass::init(obj, name, CLASS.as_mut_ptr())
+        };
+    }};
+}
+
+/// A trait for types that need a lock class during initialisation.
+///
+/// Implementers of this trait benefit from the [`init_with_lockdep`] macro that generates a new
+/// class for each initialisation call site.
+pub trait NeedsLockClass {
+    /// Initialises the type instance so that it can be safely used.
+    ///
+    /// Callers are encouraged to use the [`init_with_lockdep`] macro as it automatically creates a
+    /// new lock class on each usage.
+    ///
+    /// # Safety
+    ///
+    /// `key` must point to a valid memory location as it will be used by the kernel.
+    unsafe fn init(self: Pin<&mut Self>, name: &'static CStr, key: *mut bindings::lock_class_key);
+}
+
+/// Reschedules the caller's task if needed.
+pub fn cond_resched() -> bool {
+    // SAFETY: No arguments, reschedules `current` if needed.
+    unsafe { rust_helper_cond_resched() != 0 }
+}
diff --git a/rust/kernel/sync/mutex.rs b/rust/kernel/sync/mutex.rs
new file mode 100644
index 00000000000..36605e8cdd6
--- /dev/null
+++ b/rust/kernel/sync/mutex.rs
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A kernel mutex.
+//!
+//! This module allows Rust code to use the kernel's [`struct mutex`].
+
+use super::{Guard, Lock, NeedsLockClass};
+use crate::bindings;
+use crate::str::CStr;
+use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
+
+/// Safely initialises a [`Mutex`] with the given name, generating a new lock class.
+#[macro_export]
+macro_rules! mutex_init {
+    ($mutex:expr, $name:literal) => {
+        $crate::init_with_lockdep!($mutex, $name)
+    };
+}
+
+/// Exposes the kernel's [`struct mutex`]. When multiple threads attempt to lock the same mutex,
+/// only one at a time is allowed to progress, the others will block (sleep) until the mutex is
+/// unlocked, at which point another thread will be allowed to wake up and make progress.
+///
+/// A [`Mutex`] must first be initialised with a call to [`Mutex::init`] before it can be used. The
+/// [`mutex_init`] macro is provided to automatically assign a new lock class to a mutex instance.
+///
+/// Since it may block, [`Mutex`] needs to be used with care in atomic contexts.
+///
+/// [`struct mutex`]: ../../../include/linux/mutex.h
+pub struct Mutex<T: ?Sized> {
+    /// The kernel `struct mutex` object.
+    mutex: UnsafeCell<bindings::mutex>,
+
+    /// A mutex needs to be pinned because it contains a [`struct list_head`] that is
+    /// self-referential, so it cannot be safely moved once it is initialised.
+    _pin: PhantomPinned,
+
+    /// The data protected by the mutex.
+    data: UnsafeCell<T>,
+}
+
+// SAFETY: `Mutex` can be transferred across thread boundaries iff the data it protects can.
+unsafe impl<T: ?Sized + Send> Send for Mutex<T> {}
+
+// SAFETY: `Mutex` serialises the interior mutability it provides, so it is `Sync` as long as the
+// data it protects is `Send`.
+unsafe impl<T: ?Sized + Send> Sync for Mutex<T> {}
+
+impl<T> Mutex<T> {
+    /// Constructs a new mutex.
+    ///
+    /// # Safety
+    ///
+    /// The caller must call [`Mutex::init`] before using the mutex.
+    pub unsafe fn new(t: T) -> Self {
+        Self {
+            mutex: UnsafeCell::new(bindings::mutex::default()),
+            data: UnsafeCell::new(t),
+            _pin: PhantomPinned,
+        }
+    }
+}
+
+impl<T: ?Sized> Mutex<T> {
+    /// Locks the mutex and gives the caller access to the data protected by it. Only one thread at
+    /// a time is allowed to access the protected data.
+    pub fn lock(&self) -> Guard<'_, Self> {
+        self.lock_noguard();
+        // SAFETY: The mutex was just acquired.
+        unsafe { Guard::new(self) }
+    }
+}
+
+impl<T: ?Sized> NeedsLockClass for Mutex<T> {
+    unsafe fn init(self: Pin<&mut Self>, name: &'static CStr, key: *mut bindings::lock_class_key) {
+        unsafe { bindings::__mutex_init(self.mutex.get(), name.as_char_ptr(), key) };
+    }
+}
+
+extern "C" {
+    fn rust_helper_mutex_lock(mutex: *mut bindings::mutex);
+}
+
+impl<T: ?Sized> Lock for Mutex<T> {
+    type Inner = T;
+
+    fn lock_noguard(&self) {
+        // SAFETY: `mutex` points to valid memory.
+        unsafe {
+            rust_helper_mutex_lock(self.mutex.get());
+        }
+    }
+
+    unsafe fn unlock(&self) {
+        unsafe { bindings::mutex_unlock(self.mutex.get()) };
+    }
+
+    fn locked_data(&self) -> &UnsafeCell<T> {
+        &self.data
+    }
+}
diff --git a/rust/kernel/sync/spinlock.rs b/rust/kernel/sync/spinlock.rs
new file mode 100644
index 00000000000..c6e38ef85b0
--- /dev/null
+++ b/rust/kernel/sync/spinlock.rs
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A kernel spinlock.
+//!
+//! This module allows Rust code to use the kernel's [`struct spinlock`].
+//!
+//! See <https://www.kernel.org/doc/Documentation/locking/spinlocks.txt>.
+
+use super::{Guard, Lock, NeedsLockClass};
+use crate::str::CStr;
+use crate::{bindings, c_types};
+use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
+
+extern "C" {
+    #[allow(improper_ctypes)]
+    fn rust_helper_spin_lock_init(
+        lock: *mut bindings::spinlock_t,
+        name: *const c_types::c_char,
+        key: *mut bindings::lock_class_key,
+    );
+    fn rust_helper_spin_lock(lock: *mut bindings::spinlock);
+    fn rust_helper_spin_unlock(lock: *mut bindings::spinlock);
+}
+
+/// Safely initialises a [`SpinLock`] with the given name, generating a new lock class.
+#[macro_export]
+macro_rules! spinlock_init {
+    ($spinlock:expr, $name:literal) => {
+        $crate::init_with_lockdep!($spinlock, $name)
+    };
+}
+
+/// Exposes the kernel's [`spinlock_t`]. When multiple CPUs attempt to lock the same spinlock, only
+/// one at a time is allowed to progress, the others will block (spinning) until the spinlock is
+/// unlocked, at which point another CPU will be allowed to make progress.
+///
+/// A [`SpinLock`] must first be initialised with a call to [`SpinLock::init`] before it can be
+/// used. The [`spinlock_init`] macro is provided to automatically assign a new lock class to a
+/// spinlock instance.
+///
+/// [`SpinLock`] does not manage the interrupt state, so it can be used in only two cases: (a) when
+/// the caller knows that interrupts are disabled, or (b) when callers never use it in interrupt
+/// handlers (in which case it is ok for interrupts to be enabled).
+///
+/// [`spinlock_t`]: ../../../include/linux/spinlock.h
+pub struct SpinLock<T: ?Sized> {
+    spin_lock: UnsafeCell<bindings::spinlock>,
+
+    /// Spinlocks are architecture-defined. So we conservatively require them to be pinned in case
+    /// some architecture uses self-references now or in the future.
+    _pin: PhantomPinned,
+
+    data: UnsafeCell<T>,
+}
+
+// SAFETY: `SpinLock` can be transferred across thread boundaries iff the data it protects can.
+unsafe impl<T: ?Sized + Send> Send for SpinLock<T> {}
+
+// SAFETY: `SpinLock` serialises the interior mutability it provides, so it is `Sync` as long as the
+// data it protects is `Send`.
+unsafe impl<T: ?Sized + Send> Sync for SpinLock<T> {}
+
+impl<T> SpinLock<T> {
+    /// Constructs a new spinlock.
+    ///
+    /// # Safety
+    ///
+    /// The caller must call [`SpinLock::init`] before using the spinlock.
+    pub unsafe fn new(t: T) -> Self {
+        Self {
+            spin_lock: UnsafeCell::new(bindings::spinlock::default()),
+            data: UnsafeCell::new(t),
+            _pin: PhantomPinned,
+        }
+    }
+}
+
+impl<T: ?Sized> SpinLock<T> {
+    /// Locks the spinlock and gives the caller access to the data protected by it. Only one thread
+    /// at a time is allowed to access the protected data.
+    pub fn lock(&self) -> Guard<'_, Self> {
+        self.lock_noguard();
+        // SAFETY: The spinlock was just acquired.
+        unsafe { Guard::new(self) }
+    }
+}
+
+impl<T: ?Sized> NeedsLockClass for SpinLock<T> {
+    unsafe fn init(self: Pin<&mut Self>, name: &'static CStr, key: *mut bindings::lock_class_key) {
+        unsafe { rust_helper_spin_lock_init(self.spin_lock.get(), name.as_char_ptr(), key) };
+    }
+}
+
+impl<T: ?Sized> Lock for SpinLock<T> {
+    type Inner = T;
+
+    fn lock_noguard(&self) {
+        // SAFETY: `spin_lock` points to valid memory.
+        unsafe { rust_helper_spin_lock(self.spin_lock.get()) };
+    }
+
+    unsafe fn unlock(&self) {
+        unsafe { rust_helper_spin_unlock(self.spin_lock.get()) };
+    }
+
+    fn locked_data(&self) -> &UnsafeCell<T> {
+        &self.data
+    }
+}
diff --git a/rust/kernel/sysctl.rs b/rust/kernel/sysctl.rs
new file mode 100644
index 00000000000..42a2c7c8182
--- /dev/null
+++ b/rust/kernel/sysctl.rs
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! System control.
+//!
+//! C header: [`include/linux/sysctl.h`](../../../../include/linux/sysctl.h)
+//!
+//! Reference: <https://www.kernel.org/doc/Documentation/sysctl/README>
+
+use alloc::boxed::Box;
+use alloc::vec;
+use core::mem;
+use core::ptr;
+use core::sync::atomic;
+
+use crate::{
+    bindings, c_types, error,
+    io_buffer::IoBufferWriter,
+    str::CStr,
+    types,
+    user_ptr::{UserSlicePtr, UserSlicePtrWriter},
+};
+
+/// Sysctl storage.
+pub trait SysctlStorage: Sync {
+    /// Writes a byte slice.
+    fn store_value(&self, data: &[u8]) -> (usize, error::Result);
+
+    /// Reads via a [`UserSlicePtrWriter`].
+    fn read_value(&self, data: &mut UserSlicePtrWriter) -> (usize, error::Result);
+}
+
+fn trim_whitespace(mut data: &[u8]) -> &[u8] {
+    while !data.is_empty() && (data[0] == b' ' || data[0] == b'\t' || data[0] == b'\n') {
+        data = &data[1..];
+    }
+    while !data.is_empty()
+        && (data[data.len() - 1] == b' '
+            || data[data.len() - 1] == b'\t'
+            || data[data.len() - 1] == b'\n')
+    {
+        data = &data[..data.len() - 1];
+    }
+    data
+}
+
+impl<T> SysctlStorage for &T
+where
+    T: SysctlStorage,
+{
+    fn store_value(&self, data: &[u8]) -> (usize, error::Result) {
+        (*self).store_value(data)
+    }
+
+    fn read_value(&self, data: &mut UserSlicePtrWriter) -> (usize, error::Result) {
+        (*self).read_value(data)
+    }
+}
+
+impl SysctlStorage for atomic::AtomicBool {
+    fn store_value(&self, data: &[u8]) -> (usize, error::Result) {
+        let result = match trim_whitespace(data) {
+            b"0" => {
+                self.store(false, atomic::Ordering::Relaxed);
+                Ok(())
+            }
+            b"1" => {
+                self.store(true, atomic::Ordering::Relaxed);
+                Ok(())
+            }
+            _ => Err(error::Error::EINVAL),
+        };
+        (data.len(), result)
+    }
+
+    fn read_value(&self, data: &mut UserSlicePtrWriter) -> (usize, error::Result) {
+        let value = if self.load(atomic::Ordering::Relaxed) {
+            b"1\n"
+        } else {
+            b"0\n"
+        };
+        (value.len(), data.write_slice(value))
+    }
+}
+
+/// Holds a single `sysctl` entry (and its table).
+pub struct Sysctl<T: SysctlStorage> {
+    inner: Box<T>,
+    // Responsible for keeping the `ctl_table` alive.
+    _table: Box<[bindings::ctl_table]>,
+    header: *mut bindings::ctl_table_header,
+}
+
+// SAFETY: The only public method we have is `get()`, which returns `&T`, and
+// `T: Sync`. Any new methods must adhere to this requirement.
+unsafe impl<T: SysctlStorage> Sync for Sysctl<T> {}
+
+unsafe extern "C" fn proc_handler<T: SysctlStorage>(
+    ctl: *mut bindings::ctl_table,
+    write: c_types::c_int,
+    buffer: *mut c_types::c_void,
+    len: *mut usize,
+    ppos: *mut bindings::loff_t,
+) -> c_types::c_int {
+    // If we are reading from some offset other than the beginning of the file,
+    // return an empty read to signal EOF.
+    if unsafe { *ppos } != 0 && write == 0 {
+        unsafe { *len = 0 };
+        return 0;
+    }
+
+    let data = unsafe { UserSlicePtr::new(buffer, *len) };
+    let storage = unsafe { &*((*ctl).data as *const T) };
+    let (bytes_processed, result) = if write != 0 {
+        let data = match data.read_all() {
+            Ok(r) => r,
+            Err(e) => return e.to_kernel_errno(),
+        };
+        storage.store_value(&data)
+    } else {
+        let mut writer = data.writer();
+        storage.read_value(&mut writer)
+    };
+    unsafe { *len = bytes_processed };
+    unsafe { *ppos += *len as bindings::loff_t };
+    match result {
+        Ok(()) => 0,
+        Err(e) => e.to_kernel_errno(),
+    }
+}
+
+impl<T: SysctlStorage> Sysctl<T> {
+    /// Registers a single entry in `sysctl`.
+    pub fn register(
+        path: &'static CStr,
+        name: &'static CStr,
+        storage: T,
+        mode: types::Mode,
+    ) -> error::Result<Sysctl<T>> {
+        if name.contains(&b'/') {
+            return Err(error::Error::EINVAL);
+        }
+
+        let storage = Box::try_new(storage)?;
+        let mut table = vec![
+            bindings::ctl_table {
+                procname: name.as_char_ptr(),
+                mode: mode.as_int(),
+                data: &*storage as *const T as *mut c_types::c_void,
+                proc_handler: Some(proc_handler::<T>),
+
+                maxlen: 0,
+                child: ptr::null_mut(),
+                poll: ptr::null_mut(),
+                extra1: ptr::null_mut(),
+                extra2: ptr::null_mut(),
+            },
+            unsafe { mem::zeroed() },
+        ]
+        .try_into_boxed_slice()?;
+
+        let result = unsafe { bindings::register_sysctl(path.as_char_ptr(), table.as_mut_ptr()) };
+        if result.is_null() {
+            return Err(error::Error::ENOMEM);
+        }
+
+        Ok(Sysctl {
+            inner: storage,
+            _table: table,
+            header: result,
+        })
+    }
+
+    /// Gets the storage.
+    pub fn get(&self) -> &T {
+        &self.inner
+    }
+}
+
+impl<T: SysctlStorage> Drop for Sysctl<T> {
+    fn drop(&mut self) {
+        unsafe {
+            bindings::unregister_sysctl_table(self.header);
+        }
+        self.header = ptr::null_mut();
+    }
+}
+
+#[cfg(test)]
+mod tests {
+    use super::*;
+
+    #[test]
+    fn test_trim_whitespace() {
+        assert_eq!(trim_whitespace(b"foo    "), b"foo");
+        assert_eq!(trim_whitespace(b"    foo"), b"foo");
+        assert_eq!(trim_whitespace(b"  foo  "), b"foo");
+    }
+}
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
new file mode 100644
index 00000000000..dcf376b992e
--- /dev/null
+++ b/rust/kernel/task.rs
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Tasks (threads and processes).
+//!
+//! C header: [`include/linux/sched.h`](../../../../include/linux/sched.h).
+
+use crate::{bindings, c_types};
+use core::{marker::PhantomData, mem::ManuallyDrop, ops::Deref};
+
+extern "C" {
+    #[allow(improper_ctypes)]
+    fn rust_helper_signal_pending(t: *const bindings::task_struct) -> c_types::c_int;
+    #[allow(improper_ctypes)]
+    fn rust_helper_get_current() -> *mut bindings::task_struct;
+    #[allow(improper_ctypes)]
+    fn rust_helper_get_task_struct(t: *mut bindings::task_struct);
+    #[allow(improper_ctypes)]
+    fn rust_helper_put_task_struct(t: *mut bindings::task_struct);
+}
+
+/// Wraps the kernel's `struct task_struct`.
+///
+/// # Invariants
+///
+/// The pointer `Task::ptr` is non-null and valid. Its reference count is also non-zero.
+///
+/// # Examples
+///
+/// The following is an example of getting the PID of the current thread with zero additional cost
+/// when compared to the C version:
+///
+/// ```
+/// # use kernel::prelude::*;
+/// use kernel::task::Task;
+///
+/// # fn test() {
+/// Task::current().pid();
+/// # }
+/// ```
+///
+/// Getting the PID of the current process, also zero additional cost:
+///
+/// ```
+/// # use kernel::prelude::*;
+/// use kernel::task::Task;
+///
+/// # fn test() {
+/// Task::current().group_leader().pid();
+/// # }
+/// ```
+///
+/// Getting the current task and storing it in some struct. The reference count is automatically
+/// incremented when creating `State` and decremented when it is dropped:
+///
+/// ```
+/// # use kernel::prelude::*;
+/// use kernel::task::Task;
+///
+/// struct State {
+///     creator: Task,
+///     index: u32,
+/// }
+///
+/// impl State {
+///     fn new() -> Self {
+///         Self {
+///             creator: Task::current().clone(),
+///             index: 0,
+///         }
+///     }
+/// }
+/// ```
+pub struct Task {
+    pub(crate) ptr: *mut bindings::task_struct,
+}
+
+// SAFETY: Given that the task is referenced, it is OK to send it to another thread.
+unsafe impl Send for Task {}
+
+// SAFETY: It's OK to access `Task` through references from other threads because we're either
+// accessing properties that don't change (e.g., `pid`, `group_leader`) or that are properly
+// synchronised by C code (e.g., `signal_pending`).
+unsafe impl Sync for Task {}
+
+/// The type of process identifiers (PIDs).
+type Pid = bindings::pid_t;
+
+impl Task {
+    /// Returns a task reference for the currently executing task/thread.
+    pub fn current<'a>() -> TaskRef<'a> {
+        // SAFETY: Just an FFI call.
+        let ptr = unsafe { rust_helper_get_current() };
+
+        // SAFETY: If the current thread is still running, the current task is valid. Given
+        // that `TaskRef` is not `Send`, we know it cannot be transferred to another thread (where
+        // it could potentially outlive the caller).
+        unsafe { TaskRef::from_ptr(ptr) }
+    }
+
+    /// Returns the group leader of the given task.
+    pub fn group_leader(&self) -> TaskRef<'_> {
+        // SAFETY: By the type invariant, we know that `self.ptr` is non-null and valid.
+        let ptr = unsafe { (*self.ptr).group_leader };
+
+        // SAFETY: The lifetime of the returned task reference is tied to the lifetime of `self`,
+        // and given that a task has a reference to its group leader, we know it must be valid for
+        // the lifetime of the returned task reference.
+        unsafe { TaskRef::from_ptr(ptr) }
+    }
+
+    /// Returns the PID of the given task.
+    pub fn pid(&self) -> Pid {
+        // SAFETY: By the type invariant, we know that `self.ptr` is non-null and valid.
+        unsafe { (*self.ptr).pid }
+    }
+
+    /// Determines whether the given task has pending signals.
+    pub fn signal_pending(&self) -> bool {
+        // SAFETY: By the type invariant, we know that `self.ptr` is non-null and valid.
+        unsafe { rust_helper_signal_pending(self.ptr) != 0 }
+    }
+}
+
+impl PartialEq for Task {
+    fn eq(&self, other: &Self) -> bool {
+        self.ptr == other.ptr
+    }
+}
+
+impl Eq for Task {}
+
+impl Clone for Task {
+    fn clone(&self) -> Self {
+        // SAFETY: The type invariants guarantee that `self.ptr` has a non-zero reference count.
+        unsafe { rust_helper_get_task_struct(self.ptr) };
+
+        // INVARIANT: We incremented the reference count to account for the new `Task` being
+        // created.
+        Self { ptr: self.ptr }
+    }
+}
+
+impl Drop for Task {
+    fn drop(&mut self) {
+        // INVARIANT: We may decrement the refcount to zero, but the `Task` is being dropped, so
+        // this is not observable.
+        // SAFETY: The type invariants guarantee that `Task::ptr` has a non-zero reference count.
+        unsafe { rust_helper_put_task_struct(self.ptr) };
+    }
+}
+
+/// A wrapper for [`Task`] that doesn't automatically decrement the refcount when dropped.
+///
+/// We need the wrapper because [`ManuallyDrop`] alone would allow callers to call
+/// [`ManuallyDrop::into_inner`]. This would allow an unsafe sequence to be triggered without
+/// `unsafe` blocks because it would trigger an unbalanced call to `put_task_struct`.
+///
+/// We make this explicitly not [`Send`] so that we can use it to represent the current thread
+/// without having to increment/decrement its reference count.
+///
+/// # Invariants
+///
+/// The wrapped [`Task`] remains valid for the lifetime of the object.
+pub struct TaskRef<'a> {
+    task: ManuallyDrop<Task>,
+    _not_send: PhantomData<(&'a (), *mut ())>,
+}
+
+impl TaskRef<'_> {
+    /// Constructs a new `struct task_struct` wrapper that doesn't change its reference count.
+    ///
+    /// # Safety
+    ///
+    /// The pointer `ptr` must be non-null and valid for the lifetime of the object.
+    pub(crate) unsafe fn from_ptr(ptr: *mut bindings::task_struct) -> Self {
+        Self {
+            task: ManuallyDrop::new(Task { ptr }),
+            _not_send: PhantomData,
+        }
+    }
+}
+
+// SAFETY: It is OK to share a reference to the current thread with another thread because we know
+// the owner cannot go away while the shared reference exists (and `Task` itself is `Sync`).
+unsafe impl Sync for TaskRef<'_> {}
+
+impl Deref for TaskRef<'_> {
+    type Target = Task;
+
+    fn deref(&self) -> &Self::Target {
+        self.task.deref()
+    }
+}
diff --git a/rust/kernel/traits.rs b/rust/kernel/traits.rs
new file mode 100644
index 00000000000..39a43169bf7
--- /dev/null
+++ b/rust/kernel/traits.rs
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Traits useful to drivers, and their implementations for common types.
+
+use core::{ops::Deref, pin::Pin};
+
+use alloc::{alloc::AllocError, sync::Arc};
+
+/// Trait which provides a fallible version of `pin()` for pointer types.
+///
+/// Common pointer types which implement a `pin()` method include [`Box`](alloc::boxed::Box) and [`Arc`].
+pub trait TryPin<P: Deref> {
+    /// Constructs a new `Pin<pointer<T>>`. If `T` does not implement [`Unpin`], then data
+    /// will be pinned in memory and unable to be moved. An error will be returned
+    /// if allocation fails.
+    fn try_pin(data: P::Target) -> core::result::Result<Pin<P>, AllocError>;
+}
+
+impl<T> TryPin<Arc<T>> for Arc<T> {
+    fn try_pin(data: T) -> core::result::Result<Pin<Arc<T>>, AllocError> {
+        // SAFETY: the data `T` is exposed only through a `Pin<Arc<T>>`, which
+        // does not allow data to move out of the `Arc`. Therefore it can
+        // never be moved.
+        Ok(unsafe { Pin::new_unchecked(Arc::try_new(data)?) })
+    }
+}
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
new file mode 100644
index 00000000000..2146ee819cc
--- /dev/null
+++ b/rust/kernel/types.rs
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Kernel types.
+//!
+//! C header: [`include/linux/types.h`](../../../../include/linux/types.h)
+
+use crate::{
+    bindings, c_types,
+    sync::{Ref, RefBorrow},
+};
+use alloc::{boxed::Box, sync::Arc};
+use core::{ops::Deref, pin::Pin, ptr::NonNull};
+
+/// Permissions.
+///
+/// C header: [`include/uapi/linux/stat.h`](../../../../include/uapi/linux/stat.h)
+///
+/// C header: [`include/linux/stat.h`](../../../../include/linux/stat.h)
+pub struct Mode(bindings::umode_t);
+
+impl Mode {
+    /// Creates a [`Mode`] from an integer.
+    pub fn from_int(m: u16) -> Mode {
+        Mode(m)
+    }
+
+    /// Returns the mode as an integer.
+    pub fn as_int(&self) -> u16 {
+        self.0
+    }
+}
+
+/// Used to convert an object into a raw pointer that represents it.
+///
+/// It can eventually be converted back into the object. This is used to store objects as pointers
+/// in kernel data structures, for example, an implementation of [`FileOperations`] in `struct
+/// file::private_data`.
+pub trait PointerWrapper {
+    /// Type of values borrowed between calls to [`PointerWrapper::into_pointer`] and
+    /// [`PointerWrapper::from_pointer`].
+    type Borrowed: Deref;
+
+    /// Returns the raw pointer.
+    fn into_pointer(self) -> *const c_types::c_void;
+
+    /// Returns a borrowed value.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must have been returned by a previous call to [`PointerWrapper::into_pointer`].
+    /// Additionally, [`PointerWrapper::from_pointer`] can only be called after *all* values
+    /// returned by [`PointerWrapper::borrow`] have been dropped.
+    unsafe fn borrow(ptr: *const c_types::c_void) -> Self::Borrowed;
+
+    /// Returns the instance back from the raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// The passed pointer must come from a previous call to [`PointerWrapper::into_pointer()`].
+    unsafe fn from_pointer(ptr: *const c_types::c_void) -> Self;
+}
+
+impl<T> PointerWrapper for Box<T> {
+    type Borrowed = UnsafeReference<T>;
+
+    fn into_pointer(self) -> *const c_types::c_void {
+        Box::into_raw(self) as _
+    }
+
+    unsafe fn borrow(ptr: *const c_types::c_void) -> Self::Borrowed {
+        // SAFETY: The safety requirements for this function ensure that the object is still alive,
+        // so it is safe to dereference the raw pointer.
+        // The safety requirements also ensure that the object remains alive for the lifetime of
+        // the returned value.
+        unsafe { UnsafeReference::new(&*ptr.cast()) }
+    }
+
+    unsafe fn from_pointer(ptr: *const c_types::c_void) -> Self {
+        // SAFETY: The passed pointer comes from a previous call to [`Self::into_pointer()`].
+        unsafe { Box::from_raw(ptr as _) }
+    }
+}
+
+impl<T> PointerWrapper for Ref<T> {
+    type Borrowed = RefBorrow<T>;
+
+    fn into_pointer(self) -> *const c_types::c_void {
+        Ref::into_usize(self) as _
+    }
+
+    unsafe fn borrow(ptr: *const c_types::c_void) -> Self::Borrowed {
+        // SAFETY: The safety requirements for this function ensure that the underlying object
+        // remains valid for the lifetime of the returned value.
+        unsafe { Ref::borrow_usize(ptr as _) }
+    }
+
+    unsafe fn from_pointer(ptr: *const c_types::c_void) -> Self {
+        // SAFETY: The passed pointer comes from a previous call to [`Self::into_pointer()`].
+        unsafe { Ref::from_usize(ptr as _) }
+    }
+}
+
+impl<T> PointerWrapper for Arc<T> {
+    type Borrowed = UnsafeReference<T>;
+
+    fn into_pointer(self) -> *const c_types::c_void {
+        Arc::into_raw(self) as _
+    }
+
+    unsafe fn borrow(ptr: *const c_types::c_void) -> Self::Borrowed {
+        // SAFETY: The safety requirements for this function ensure that the object is still alive,
+        // so it is safe to dereference the raw pointer.
+        // The safety requirements also ensure that the object remains alive for the lifetime of
+        // the returned value.
+        unsafe { UnsafeReference::new(&*ptr.cast()) }
+    }
+
+    unsafe fn from_pointer(ptr: *const c_types::c_void) -> Self {
+        // SAFETY: The passed pointer comes from a previous call to [`Self::into_pointer()`].
+        unsafe { Arc::from_raw(ptr as _) }
+    }
+}
+
+/// A reference with manually-managed lifetime.
+///
+/// # Invariants
+///
+/// There are no mutable references to the underlying object, and it remains valid for the lifetime
+/// of the [`UnsafeReference`] instance.
+pub struct UnsafeReference<T: ?Sized> {
+    ptr: NonNull<T>,
+}
+
+impl<T: ?Sized> UnsafeReference<T> {
+    /// Creates a new [`UnsafeReference`] instance.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure the following for the lifetime of the returned [`UnsafeReference`]
+    /// instance:
+    /// 1. That `obj` remains valid;
+    /// 2. That no mutable references to `obj` are created.
+    unsafe fn new(obj: &T) -> Self {
+        // INVARIANT: The safety requirements of this function ensure that the invariants hold.
+        Self {
+            ptr: NonNull::from(obj),
+        }
+    }
+}
+
+impl<T: ?Sized> Deref for UnsafeReference<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: By the type invariant, the object is still valid and alive, and there are no
+        // mutable references to it.
+        unsafe { self.ptr.as_ref() }
+    }
+}
+
+impl<T: PointerWrapper + Deref> PointerWrapper for Pin<T> {
+    type Borrowed = T::Borrowed;
+
+    fn into_pointer(self) -> *const c_types::c_void {
+        // SAFETY: We continue to treat the pointer as pinned by returning just a pointer to it to
+        // the caller.
+        let inner = unsafe { Pin::into_inner_unchecked(self) };
+        inner.into_pointer()
+    }
+
+    unsafe fn borrow(ptr: *const c_types::c_void) -> Self::Borrowed {
+        // SAFETY: The safety requirements for this function are the same as the ones for
+        // `T::borrow`.
+        unsafe { T::borrow(ptr) }
+    }
+
+    unsafe fn from_pointer(p: *const c_types::c_void) -> Self {
+        // SAFETY: The object was originally pinned.
+        // The passed pointer comes from a previous call to `inner::into_pointer()`.
+        unsafe { Pin::new_unchecked(T::from_pointer(p)) }
+    }
+}
+
+/// Runs a cleanup function/closure when dropped.
+///
+/// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.
+///
+/// # Examples
+///
+/// In the example below, we have multiple exit paths and we want to log regardless of which one is
+/// taken:
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::ScopeGuard;
+/// fn example1(arg: bool) {
+///     let _log = ScopeGuard::new(|| pr_info!("example1 completed\n"));
+///
+///     if arg {
+///         return;
+///     }
+///
+///     // Do something...
+/// }
+/// ```
+///
+/// In the example below, we want to log the same message on all early exits but a different one on
+/// the main exit path:
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::ScopeGuard;
+/// fn example2(arg: bool) {
+///     let log = ScopeGuard::new(|| pr_info!("example2 returned early\n"));
+///
+///     if arg {
+///         return;
+///     }
+///
+///     // (Other early returns...)
+///
+///     log.dismiss();
+///     pr_info!("example2 no early return\n");
+/// }
+/// ```
+pub struct ScopeGuard<T: FnOnce()> {
+    cleanup_func: Option<T>,
+}
+
+impl<T: FnOnce()> ScopeGuard<T> {
+    /// Creates a new cleanup object with the given cleanup function.
+    pub fn new(cleanup_func: T) -> Self {
+        Self {
+            cleanup_func: Some(cleanup_func),
+        }
+    }
+
+    /// Prevents the cleanup function from running.
+    pub fn dismiss(mut self) {
+        self.cleanup_func.take();
+    }
+}
+
+impl<T: FnOnce()> Drop for ScopeGuard<T> {
+    fn drop(&mut self) {
+        // Run the cleanup function if one is still present.
+        if let Some(cleanup) = self.cleanup_func.take() {
+            cleanup();
+        }
+    }
+}
diff --git a/rust/kernel/user_ptr.rs b/rust/kernel/user_ptr.rs
new file mode 100644
index 00000000000..71ec659bcee
--- /dev/null
+++ b/rust/kernel/user_ptr.rs
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! User pointers.
+//!
+//! C header: [`include/linux/uaccess.h`](../../../../include/linux/uaccess.h)
+
+use crate::{
+    c_types,
+    error::Error,
+    io_buffer::{IoBufferReader, IoBufferWriter},
+    Result,
+};
+use alloc::vec::Vec;
+
+extern "C" {
+    fn rust_helper_copy_from_user(
+        to: *mut c_types::c_void,
+        from: *const c_types::c_void,
+        n: c_types::c_ulong,
+    ) -> c_types::c_ulong;
+
+    fn rust_helper_copy_to_user(
+        to: *mut c_types::c_void,
+        from: *const c_types::c_void,
+        n: c_types::c_ulong,
+    ) -> c_types::c_ulong;
+
+    fn rust_helper_clear_user(to: *mut c_types::c_void, n: c_types::c_ulong) -> c_types::c_ulong;
+}
+
+/// A reference to an area in userspace memory, which can be either
+/// read-only or read-write.
+///
+/// All methods on this struct are safe: invalid pointers return
+/// `EFAULT`. Concurrent access, *including data races to/from userspace
+/// memory*, is permitted, because fundamentally another userspace
+/// thread/process could always be modifying memory at the same time
+/// (in the same way that userspace Rust's [`std::io`] permits data races
+/// with the contents of files on disk). In the presence of a race, the
+/// exact byte values read/written are unspecified but the operation is
+/// well-defined. Kernelspace code should validate its copy of data
+/// after completing a read, and not expect that multiple reads of the
+/// same address will return the same value.
+///
+/// All APIs enforce the invariant that a given byte of memory from userspace
+/// may only be read once. By preventing double-fetches we avoid TOCTOU
+/// vulnerabilities. This is accomplished by taking `self` by value to prevent
+/// obtaining multiple readers on a given [`UserSlicePtr`], and the readers
+/// only permitting forward reads.
+///
+/// Constructing a [`UserSlicePtr`] performs no checks on the provided
+/// address and length, it can safely be constructed inside a kernel thread
+/// with no current userspace process. Reads and writes wrap the kernel APIs
+/// `copy_from_user` and `copy_to_user`, which check the memory map of the
+/// current process and enforce that the address range is within the user
+/// range (no additional calls to `access_ok` are needed).
+///
+/// [`std::io`]: https://doc.rust-lang.org/std/io/index.html
+pub struct UserSlicePtr(*mut c_types::c_void, usize);
+
+impl UserSlicePtr {
+    /// Constructs a user slice from a raw pointer and a length in bytes.
+    ///
+    /// # Safety
+    ///
+    /// Callers must be careful to avoid time-of-check-time-of-use
+    /// (TOCTOU) issues. The simplest way is to create a single instance of
+    /// [`UserSlicePtr`] per user memory block as it reads each byte at
+    /// most once.
+    pub unsafe fn new(ptr: *mut c_types::c_void, length: usize) -> Self {
+        UserSlicePtr(ptr, length)
+    }
+
+    /// Reads the entirety of the user slice.
+    ///
+    /// Returns `EFAULT` if the address does not currently point to
+    /// mapped, readable memory.
+    pub fn read_all(self) -> Result<Vec<u8>> {
+        self.reader().read_all()
+    }
+
+    /// Constructs a [`UserSlicePtrReader`].
+    pub fn reader(self) -> UserSlicePtrReader {
+        UserSlicePtrReader(self.0, self.1)
+    }
+
+    /// Writes the provided slice into the user slice.
+    ///
+    /// Returns `EFAULT` if the address does not currently point to
+    /// mapped, writable memory (in which case some data from before the
+    /// fault may be written), or `data` is larger than the user slice
+    /// (in which case no data is written).
+    pub fn write_all(self, data: &[u8]) -> Result {
+        self.writer().write_slice(data)
+    }
+
+    /// Constructs a [`UserSlicePtrWriter`].
+    pub fn writer(self) -> UserSlicePtrWriter {
+        UserSlicePtrWriter(self.0, self.1)
+    }
+
+    /// Constructs both a [`UserSlicePtrReader`] and a [`UserSlicePtrWriter`].
+    pub fn reader_writer(self) -> (UserSlicePtrReader, UserSlicePtrWriter) {
+        (
+            UserSlicePtrReader(self.0, self.1),
+            UserSlicePtrWriter(self.0, self.1),
+        )
+    }
+}
+
+/// A reader for [`UserSlicePtr`].
+///
+/// Used to incrementally read from the user slice.
+pub struct UserSlicePtrReader(*mut c_types::c_void, usize);
+
+impl IoBufferReader for UserSlicePtrReader {
+    /// Returns the number of bytes left to be read from this.
+    ///
+    /// Note that even reading less than this number of bytes may fail.
+    fn len(&self) -> usize {
+        self.1
+    }
+
+    /// Reads raw data from the user slice into a raw kernel buffer.
+    ///
+    /// # Safety
+    ///
+    /// The output buffer must be valid.
+    unsafe fn read_raw(&mut self, out: *mut u8, len: usize) -> Result {
+        if len > self.1 || len > u32::MAX as usize {
+            return Err(Error::EFAULT);
+        }
+        let res = unsafe { rust_helper_copy_from_user(out as _, self.0, len as _) };
+        if res != 0 {
+            return Err(Error::EFAULT);
+        }
+        // Since this is not a pointer to a valid object in our program,
+        // we cannot use `add`, which has C-style rules for defined
+        // behavior.
+        self.0 = self.0.wrapping_add(len);
+        self.1 -= len;
+        Ok(())
+    }
+}
+
+/// A writer for [`UserSlicePtr`].
+///
+/// Used to incrementally write into the user slice.
+pub struct UserSlicePtrWriter(*mut c_types::c_void, usize);
+
+impl IoBufferWriter for UserSlicePtrWriter {
+    fn len(&self) -> usize {
+        self.1
+    }
+
+    fn clear(&mut self, mut len: usize) -> Result {
+        let mut ret = Ok(());
+        if len > self.1 {
+            ret = Err(Error::EFAULT);
+            len = self.1;
+        }
+
+        // SAFETY: The buffer will be validated by `clear_user`. We ensure that `len` is within
+        // bounds in the check above.
+        let left = unsafe { rust_helper_clear_user(self.0, len as _) } as usize;
+        if left != 0 {
+            ret = Err(Error::EFAULT);
+            len -= left;
+        }
+
+        self.0 = self.0.wrapping_add(len);
+        self.1 -= len;
+        ret
+    }
+
+    unsafe fn write_raw(&mut self, data: *const u8, len: usize) -> Result {
+        if len > self.1 || len > u32::MAX as usize {
+            return Err(Error::EFAULT);
+        }
+        let res = unsafe { rust_helper_copy_to_user(self.0, data as _, len as _) };
+        if res != 0 {
+            return Err(Error::EFAULT);
+        }
+        // Since this is not a pointer to a valid object in our program,
+        // we cannot use `add`, which has C-style rules for defined
+        // behavior.
+        self.0 = self.0.wrapping_add(len);
+        self.1 -= len;
+        Ok(())
+    }
+}
-- 
2.32.0

